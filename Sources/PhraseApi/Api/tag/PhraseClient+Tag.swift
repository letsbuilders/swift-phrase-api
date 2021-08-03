//
// Created by kacper on 03/08/2021.
//

import Foundation
import NIO

public extension PhraseClient.ProjectScope {
    func tags(branch: String? = nil) -> EventLoopFuture<[TagResponse]> {
        var queryItems: [URLQueryItem] = []
        if let branch = branch {
            queryItems.append(URLQueryItem(name: "branch", value: branch))
        }
        return getMany(pathComponent: "tags", responseType: TagResponse.self, queryItems: queryItems)
    }

    func tag(name: String, branch: String? = nil) -> EventLoopFuture<TagResponse> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return getOne(pathComponent: "tags", identifier: name, responseType: TagResponse.self, queryItems: queryItems)
    }

    func createTag(name: String, branch: String? = nil) -> EventLoopFuture<TagResponse> {
        let requestData = TagRequest(branch: branch, name: name)
        return createOne(pathComponent: "tags", requestData: requestData, responseType: TagResponse.self)
    }

    func deleteTag(name: String, branch: String? = nil) -> EventLoopFuture<Void> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return deleteOne(pathComponent: "tags", identifier: name, queryItems: queryItems)
    }
}