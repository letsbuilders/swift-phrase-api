//
//  BranchResponse.swift
//  PhraseTests
//
//  Created by Kacper Kawecki on 30/07/2021.
//

import Foundation

public struct BranchResponse: Decodable {
    public let baseProjectId: String?
    public let branchProjectId: String?
    public let name: String
    public let createdAt: Date
    public let updatedAt: Date?
    public let mergedAt: Date?
    public let mergedBy: PhraseUser?
    public let createdBy: PhraseUser
    public let state: String
}
