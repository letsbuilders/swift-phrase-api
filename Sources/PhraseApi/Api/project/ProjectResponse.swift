//
// Created by kacper on 29/07/2021.
//

import Foundation

struct ProjectResponse: Decodable {
    let id: String
    let name: String
    let slug: String
    let mainFormat: String?
    let projectImageUrl: String?
    let account: AccountResponse
    let space: SpaceResponse
    let createdAt: Date
    let updatedAt: Date?
    let sharesTranslationMemory: Bool
}
