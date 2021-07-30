//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct TranslationResponse: Decodable {
    public struct Key: Codable {
        let id: String
        let name: String
        let plural: Bool?
    }

    let id: String
    let content: String
    let unverified: Bool
    let excluded: Bool
    let pluralSuffix: String?
    let key: Key
    let locale: Locale
    let placeholders: [String]
    let state: String
    let createdAt: Date
    let updatedAt: Date?
    let user: PhraseUser?
    let wordCount: Int?
}
