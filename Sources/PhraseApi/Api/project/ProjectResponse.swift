//
// Created by kacper on 29/07/2021.
//

import Foundation

public struct ProjectResponse: Decodable {
    public let id: String
    public let name: String
    public let slug: String
    public let mainFormat: String?
    public let projectImageUrl: String?
    public let account: AccountResponse
    public let space: SpaceResponse
    public let createdAt: Date
    public let updatedAt: Date?
    public let sharesTranslationMemory: Bool
}
