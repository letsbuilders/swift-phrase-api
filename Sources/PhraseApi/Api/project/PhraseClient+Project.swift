//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// API
public extension PhraseClient {
    struct ProjectScope {
        let projectData: ProjectResponse
        internal let client: PhraseClient

        var projectId: String {
            projectData.id
        }

        internal var baseUrl: URL {
            client.baseUrl.appendingPathComponent("projects").appendingPathComponent(projectId)
        }

        internal var projectPathComponents: [String] {
            ["projects", projectId]
        }

        internal func getMany<ResponseType: Decodable>(pathComponent: String, responseType: ResponseType.Type, queryItems: [URLQueryItem] = []) -> EventLoopFuture<[ResponseType]> {
            getMany(pathComponents: [pathComponent], responseType: ResponseType.self, queryItems: queryItems)
        }

        internal func getMany<ResponseType: Decodable>(pathComponents: [String], responseType: ResponseType.Type, queryItems: [URLQueryItem] = []) -> EventLoopFuture<[ResponseType]> {
            client.getMany(pathComponents: projectPathComponents + pathComponents, responseType: ResponseType.self, queryItems: queryItems)
        }

        internal func getOne<ResponseType: Decodable>(pathComponent: String, identifier: String, responseType: ResponseType.Type, queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<ResponseType> {
            client.getOne(pathComponents: projectPathComponents + [pathComponent, identifier], responseType: ResponseType.self, queryItems: queryItems)
        }

        internal func createOne<RequestType: Encodable, ResponseType: Decodable>(pathComponent: String, requestData: RequestType, responseType: ResponseType.Type, queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<ResponseType> {
            client.createOne(pathComponents: projectPathComponents + [pathComponent], requestData: requestData, responseType: ResponseType.self, queryItems: queryItems)
        }

        internal func updateOne<RequestType: Encodable, ResponseType: Decodable>(pathComponent: String, identifier: String, requestData: RequestType, responseType: ResponseType.Type, queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<ResponseType> {
            client.updateOne(pathComponents: projectPathComponents + [pathComponent, identifier], requestData: requestData, responseType: ResponseType.self, queryItems: queryItems)
        }

        internal func deleteOne(pathComponent: String, identifier: String, queryItems: [URLQueryItem]? = nil) -> EventLoopFuture<Void> {
            client.deleteOne(pathComponents: projectPathComponents + [pathComponent, identifier], queryItems: queryItems)
        }
    }

    func project(id projectId: String) -> EventLoopFuture<ProjectScope> {
        getOne(pathComponents: ["projects", projectId], responseType: ProjectResponse.self).map { projectData in
            ProjectScope(projectData: projectData, client: self)
        }
    }
}
