//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// Api Branches

public extension PhraseClient.ProjectScope {
    func branches() -> EventLoopFuture<[BranchResponse]> {
        getMany(pathComponent: "branches", responseType: BranchResponse.self)
    }

    func branch(name: String) -> EventLoopFuture<BranchResponse> {
        getOne(pathComponent: "branches", identifier: name, responseType: BranchResponse.self)
    }

    func createBranch(name: String) -> EventLoopFuture<BranchResponse> {
        let requestData = BranchRequest(name: name)

        return createOne(pathComponent: "branches", requestData: requestData, responseType: BranchResponse.self)
    }

    func deleteBranch(name: String) -> EventLoopFuture<Void> {
        deleteOne(pathComponent: "branches", identifier: name)
    }
}
