//
// Created by kacper on 29/07/2021.
//

import Foundation
import AsyncHTTPClient
import Logging
import NIO
import NIOHTTP1

public enum ClientError: Error {
    case requestFailed(status: HTTPResponseStatus)
    case emptyResponse
    case wrongUrl
}

public final class PhraseClient {
    static var baseUrl = "https://api.phrase.com/v2/"

    var logger: Logger
    var userAgent = "Swift Phrase API wrapper"
    private let httpClient: HTTPClient
    private let accessToken: String
    private var deinitHttpClient: Bool = false
    
    internal var baseUrl: URL {
        URL(string: PhraseClient.baseUrl)!
    }

    public init(accessToken: String, httpClient: HTTPClient? = nil, logger: Logger = Logger(label: "com.phrase.api")) {
        self.accessToken = accessToken
        self.logger = logger
        if let httpClient = httpClient {
            self.httpClient = httpClient
        } else {
            self.httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
            self.deinitHttpClient = true
        }
    }

    deinit {
        if deinitHttpClient {
            try? self.httpClient.syncShutdown()
        }
    }

    internal func setHeaders(_ request: HTTPClient.Request) -> HTTPClient.Request {
        var modifiedRequest = request
        modifiedRequest.headers.add(name: "User-Agent", value: userAgent)
        modifiedRequest.headers.add(name: "Authorization", value: "token \(accessToken)")
        return modifiedRequest
    }

    internal func execute(_ request: HTTPClient.Request) -> EventLoopFuture<HTTPClient.Response> {
        let request = setHeaders(request)
        return self.httpClient.execute(request: request, deadline: .now() + .seconds(30), logger: logger)
    }
    
    internal func nextEventLoop() -> EventLoop {
        httpClient.eventLoopGroup.next()
    }
}

// API helpers
internal extension PhraseClient {
    private func decodeResponse<ResponseData: Decodable>(response: HTTPClient.Response) throws -> ResponseData {
        guard response.status == .ok || response.status == .created else {
            logger.error("Unexpected response received from API \(response.status.code)")
            if var body = response.body {
                logger.debug("\(body.readString(length: body.capacity, encoding: String.Encoding.utf8) ?? "Can't parse the body to sting")")
            }
            throw ClientError.requestFailed(status: response.status)
        }
        guard var body = response.body else { throw ClientError.emptyResponse }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        do {
            return try decoder.decode(ResponseData.self, from: body)
        } catch {
            logger.error("Failed parsing JSON to \(ResponseData.self) -> \(error)")
            logger.debug("\(body.readString(length: body.capacity, encoding: String.Encoding.utf8) ?? "Can't parse the body to sting")")
            throw error
        }
    }

    private func parseEmptyResponse(response: HTTPClient.Response) throws -> Void {
        guard response.status == .noContent || response.status == .created else { throw ClientError.requestFailed(status: response.status) }

        return
    }

    private func encodeRequest<RequestData: Encodable>(request: HTTPClient.Request, data: RequestData) throws -> HTTPClient.Request {
        var request = request
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        let encodedData = try encoder.encode(data)
        logger.debug("Request JSON: \(String(data: encodedData, encoding: .utf8)!)")

        request.body = .data(encodedData)
        request.headers.add(name: "Content-Type", value: "application/json")
        return request
    }

    func getMany<ResponseType: Decodable>(pathComponents: [String], responseType: ResponseType.Type, queryItems: [URLQueryItem] = []) -> EventLoopFuture<[ResponseType]> {
        do {
            var initialUrl = baseUrl
            pathComponents.forEach { initialUrl.appendPathComponent($0) }

            guard var urlComponents = URLComponents(url: initialUrl, resolvingAgainstBaseURL: true) else { throw ClientError.wrongUrl }
            urlComponents.queryItems = [ URLQueryItem(name: "per_page", value: "100") ] + queryItems

            guard let url = urlComponents.url else { throw ClientError.wrongUrl }
            logger.debug("GET \(url.absoluteString)")
            let futureResponse = execute(try HTTPClient.Request(url: url, method: .GET))

            return futureResponse.flatMapThrowing { response in
                let data: [ResponseType] = try self.decodeResponse(response: response)
                return data
            }
        } catch {
            return nextEventLoop().makeFailedFuture(error)
        }
    }

    func getOne<ResponseType: Decodable>(pathComponents: [String], responseType: ResponseType.Type, queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<ResponseType> {
        do {
            var initialUrl = baseUrl
            pathComponents.forEach { initialUrl.appendPathComponent($0) }
            guard var urlComponents = URLComponents(url: initialUrl, resolvingAgainstBaseURL: true) else { throw ClientError.wrongUrl }
            urlComponents.queryItems = queryItems

            guard let url = urlComponents.url else { throw ClientError.wrongUrl }
            logger.debug("GET \(url.absoluteString)")
            let futureResponse = execute(try HTTPClient.Request(url: url, method: .GET))

            return futureResponse.flatMapThrowing { response in
                let data: ResponseType = try self.decodeResponse(response: response)
                return data
            }
        } catch {
            return nextEventLoop().makeFailedFuture(error)
        }
    }

    func createOne<RequestType: Encodable, ResponseType: Decodable>(pathComponents: [String], requestData: RequestType, responseType: ResponseType.Type, queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<ResponseType> {
        do {
            var initialUrl = baseUrl
            pathComponents.forEach { initialUrl.appendPathComponent($0) }
            guard var urlComponents = URLComponents(url: initialUrl, resolvingAgainstBaseURL: true) else { throw ClientError.wrongUrl }
            urlComponents.queryItems = queryItems
            guard let url = urlComponents.url else { throw ClientError.wrongUrl }
            logger.debug("POST \(url.absoluteString)")

            let request = try HTTPClient.Request(url: url, method: .POST)
            let futureResponse = execute(try encodeRequest(request: request, data: requestData))

            return futureResponse.flatMapThrowing { response in
                let data: ResponseType = try self.decodeResponse(response: response)
                return data
            }
        } catch {
            return nextEventLoop().makeFailedFuture(error)
        }
    }

    func updateOne<RequestType: Encodable, ResponseType: Decodable>(pathComponents: [String], requestData: RequestType, responseType: ResponseType.Type, queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<ResponseType> {
        do {
            var initialUrl = baseUrl
            pathComponents.forEach { initialUrl.appendPathComponent($0) }
            guard var urlComponents = URLComponents(url: initialUrl, resolvingAgainstBaseURL: true) else { throw ClientError.wrongUrl }
            urlComponents.queryItems = queryItems
            guard let url = urlComponents.url else { throw ClientError.wrongUrl }
            logger.debug("PUT \(url.absoluteString)")

            let request = try HTTPClient.Request(url: url, method: .PATCH)
            let futureResponse = execute(try encodeRequest(request: request, data: requestData))

            return futureResponse.flatMapThrowing { response in
                let data: ResponseType = try self.decodeResponse(response: response)
                return data
            }
        } catch {
            return nextEventLoop().makeFailedFuture(error)
        }
    }

    func deleteOne(pathComponents: [String], queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<Void> {
        do {
            var initialUrl = baseUrl
            pathComponents.forEach { initialUrl.appendPathComponent($0) }
            guard var urlComponents = URLComponents(url: initialUrl, resolvingAgainstBaseURL: true) else { throw ClientError.wrongUrl }
            urlComponents.queryItems = queryItems
            guard let url = urlComponents.url else { throw ClientError.wrongUrl }
            logger.debug("PUT \(url.absoluteString)")

            let request = try HTTPClient.Request(url: url, method: .DELETE)
            let futureResponse = execute(request)

            return futureResponse.flatMapThrowing { response in
                try self.parseEmptyResponse(response: response)
            }
        } catch {
            return nextEventLoop().makeFailedFuture(error)
        }
    }
}


