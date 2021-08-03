//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// API - keys
extension PhraseClient.ProjectScope {
    func keys(branch: String? = nil) -> EventLoopFuture<[KeyResponse]> {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "sort_by", value: "name"),
            URLQueryItem(name: "order", value: "asc")
        ]
        if let branch = branch {
            queryItems.append(URLQueryItem(name: "branch", value: branch))
        }

        return getMany(pathComponent: "keys", responseType: KeyResponse.self, queryItems: queryItems)
    }

    func findKey(keyName: String, branch: String? = nil) -> EventLoopFuture<[KeyResponse]> {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "sort_by", value: "name"),
            URLQueryItem(name: "order", value: "asc"),
            URLQueryItem(name: "q", value: "name:\(keyName)")
        ]
        if let branch = branch {
            queryItems.append(URLQueryItem(name: "branch", value: branch))
        }
        return getMany(pathComponent: "keys", responseType: KeyResponse.self, queryItems: queryItems)
    }

    func key(id: String, branch: String? = nil) -> EventLoopFuture<KeyResponse> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return getOne(pathComponent: "keys", identifier: id, responseType: KeyResponse.self, queryItems: queryItems)
    }

    func createKey(_ keyRequest: KeyRequest) -> EventLoopFuture<KeyResponse> {
        createOne(pathComponent: "keys", requestData: keyRequest, responseType: KeyResponse.self)
    }

    func createKey(name: String, description: String? = nil, branch: String? = nil, tags: [String]? = nil, dataType: PhraseDataType = .string, maxCharactersAllowed: Int? = nil) -> EventLoopFuture<KeyResponse> {
        let requestData = KeyRequest(branch: branch, name: name, description: description, dataType: dataType, tags: tags, maxCharactersAllowed: maxCharactersAllowed)
        return createKey(requestData)
    }

    func updateKey(id: String, changes keyData: KeyRequest) -> EventLoopFuture<KeyResponse> {
        updateOne(pathComponent: "keys",identifier: id, requestData: keyData, responseType: KeyResponse.self)
    }

    func updateKey(id: String, name: String, description: String? = nil, branch: String? = nil, tags: [String]? = nil, dataType: PhraseDataType = .string, maxCharactersAllowed: Int? = nil) -> EventLoopFuture<KeyResponse> {
        let requestData = KeyRequest(branch: branch, name: name, description: description, dataType: dataType, tags: tags, maxCharactersAllowed: maxCharactersAllowed)
        return updateKey(id: id, changes: requestData)
    }
}
