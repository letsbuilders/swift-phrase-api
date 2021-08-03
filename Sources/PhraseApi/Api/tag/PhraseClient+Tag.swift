//
// Created by kacper on 03/08/2021.
//

import Foundation
import NIO

public extension PhraseClient.ProjectScope {
    /// List of tags
    ///
    /// - Parameter branch: Specify the branch to use (optional)
    /// - Returns: Future array of tags
    ///
    /// - SeeAlso: `TagResponse`
    func tags(branch: String? = nil) -> EventLoopFuture<[TagResponse]> {
        var queryItems: [URLQueryItem] = []
        if let branch = branch {
            queryItems.append(URLQueryItem(name: "branch", value: branch))
        }
        return getMany(pathComponent: "tags", responseType: TagResponse.self, queryItems: queryItems)
    }

    /// Get single tag by name
    ///
    /// - Parameters:
    ///   - name: Name of tag you want to get
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future tag
    func tag(name: String, branch: String? = nil) -> EventLoopFuture<TagResponse> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return getOne(pathComponent: "tags", identifier: name, responseType: TagResponse.self, queryItems: queryItems)
    }

    /// Create new tag
    ///
    /// - Parameters:
    ///   - name: Name of tag you want to create
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future tag
    ///
    /// - Note: Tags can be automatically created when creating new key - check `createKey`
    func createTag(name: String, branch: String? = nil) -> EventLoopFuture<TagResponse> {
        let requestData = TagRequest(branch: branch, name: name)
        return createOne(pathComponent: "tags", requestData: requestData, responseType: TagResponse.self)
    }

    /// Delete an existing tag
    ///
    /// - Parameters:
    ///   - name: Name of tag you want to delete
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future void
    func deleteTag(name: String, branch: String? = nil) -> EventLoopFuture<Void> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return deleteOne(pathComponent: "tags", identifier: name, queryItems: queryItems)
    }
}