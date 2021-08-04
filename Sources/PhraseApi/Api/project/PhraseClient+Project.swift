//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// API
public extension PhraseClient {
    struct ProjectScope {
        /// Project data loaded from API
        public let projectData: ProjectResponse

        /// Id of the project
        public var projectId: String {
            projectData.id
        }

        internal init(projectData: ProjectResponse, client: PhraseClient) {
            self.projectData = projectData
            self.client = client
        }

        internal let client: PhraseClient

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

    /// Get project data and access to project scoped APIs
    ///
    /// - Parameter projectId: Project id - you can obtain it using web UI
    /// - Returns: Future project scope
    func project(id projectId: String) -> EventLoopFuture<ProjectScope> {
        getOne(pathComponents: ["projects", projectId], responseType: ProjectResponse.self).map { projectData in
            ProjectScope(projectData: projectData, client: self)
        }
    }
}
