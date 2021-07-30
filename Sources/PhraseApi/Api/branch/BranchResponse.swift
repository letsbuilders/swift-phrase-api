//
//  BranchResponse.swift
//  PhraseTests
//
//  Created by Kacper Kawecki on 30/07/2021.
//

import Foundation

public struct BranchResponse: Decodable {
    let baseProjectId: String?
    let branchProjectId: String?
    let name: String
    let createdAt: Date
    let updatedAt: Date?
    let mergedAt: Date?
    let mergedBy: PhraseUser?
    let createdBy: PhraseUser
    let state: String
}
