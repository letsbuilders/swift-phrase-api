//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// Api Branches

public extension PhraseClient.ProjectScope {
    /// List all branches
    ///
    /// - Returns: Future array of branch
    func branches() -> EventLoopFuture<[BranchResponse]> {
        getMany(pathComponent: "branches", responseType: BranchResponse.self)
    }

    /// Get single branch by name
    ///
    /// - Parameter name: Name of branch you want to get
    /// - Returns: Future branch
    func branch(name: String) -> EventLoopFuture<BranchResponse> {
        getOne(pathComponent: "branches", identifier: name, responseType: BranchResponse.self)
    }

    /// Create new branch
    ///
    /// - Parameter name: Name of branch you want to create
    /// - Returns: Future branch
    func createBranch(name: String) -> EventLoopFuture<BranchResponse> {
        let requestData = BranchRequest(name: name)

        return createOne(pathComponent: "branches", requestData: requestData, responseType: BranchResponse.self)
    }

    /// Delete existing branch
    ///
    /// - Parameter name: Branch name you want to delete
    /// - Returns: Future branch
    func deleteBranch(name: String) -> EventLoopFuture<Void> {
        deleteOne(pathComponent: "branches", identifier: name)
    }
}
