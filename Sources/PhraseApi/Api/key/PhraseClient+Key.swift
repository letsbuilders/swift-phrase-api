//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// API - keys
extension PhraseClient.ProjectScope {
    /// List all keys
    /// 
    /// - Parameter branch: Specify the branch to use (optional)
    /// - Returns: Future list of keys
    ///
    /// - SeeAlso: `KeyResponse`
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

    /// Find key by name
    ///
    /// - Parameters:
    ///   - keyName: Key name you are looking for
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future array of keys. In most cases you can expect 0 or 1 element inside of array
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

    /// Get single key by id
    ///
    /// - Parameters:
    ///   - id: Key id
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future key
    func key(id: String, branch: String? = nil) -> EventLoopFuture<KeyResponse> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return getOne(pathComponent: "keys", identifier: id, responseType: KeyResponse.self, queryItems: queryItems)
    }

    /// Create new key
    ///
    /// - Parameter keyRequest: Key data. Check `KeyRequest` for more details.
    /// - Returns: Future key
    ///
    /// - SeeAlso: `KeyRequest`, `KeyResponse`
    func createKey(_ keyRequest: KeyRequest) -> EventLoopFuture<KeyResponse> {
        createOne(pathComponent: "keys", requestData: keyRequest, responseType: KeyResponse.self)
    }

    /// Create new key
    ///
    /// - Parameters:
    ///   - name: Key name
    ///   - description: Key description (usually includes contextual information for translators)
    ///   - branch: Specify the branch to use (optional)
    ///   - tags: List of tags to be associated with key
    ///   - dataType: Type of the key. Can be one of the following: `.string`, `.number`, `.boolean`, `.array`, `.markdown`
    ///   - maxCharactersAllowed: Maximum number of characters translations for this key can have
    /// - Returns: Future key
    ///
    /// - SeeAlso: `KeyRequest`, `KeyResponse`
    func createKey(name: String, description: String? = nil, branch: String? = nil, tags: [String]? = nil, dataType: PhraseDataType = .string, maxCharactersAllowed: Int? = nil) -> EventLoopFuture<KeyResponse> {
        let requestData = KeyRequest(branch: branch, name: name, description: description, dataType: dataType, tags: tags, maxCharactersAllowed: maxCharactersAllowed)
        return createKey(requestData)
    }

    /// Update existing key
    ///
    /// - Parameters:
    ///   - id: Id of key you want to update
    ///   - keyData: Changes you want to make. Fields with `nil` will be omitted
    /// - Returns: Future key
    func updateKey(id: String, changes keyData: KeyRequest) -> EventLoopFuture<KeyResponse> {
        updateOne(pathComponent: "keys",identifier: id, requestData: keyData, responseType: KeyResponse.self)
    }

    /// Update existing key
    ///
    /// - Parameters:
    ///   - id: Id of key you want to update
    ///   - branch: Specify the branch to use (optional)
    ///   - name: Key name
    ///   - description: Key description (usually includes contextual information for translators)
    ///   - tags: List of tags to be associated with key
    ///   - dataType: Type of the key. Can be one of the following: `.string`, `.number`, `.boolean`, `.array`, `.markdown`
    ///   - maxCharactersAllowed: Maximum number of characters translations for this key can have
    /// - Returns: Future key
    func updateKey(id: String, branch: String? = nil, name: String, description: String? = nil, tags: [String]? = nil, dataType: PhraseDataType = .string, maxCharactersAllowed: Int? = nil) -> EventLoopFuture<KeyResponse> {
        let requestData = KeyRequest(branch: branch, name: name, description: description, dataType: dataType, tags: tags, maxCharactersAllowed: maxCharactersAllowed)
        return updateKey(id: id, changes: requestData)
    }
}
