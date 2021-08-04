//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct TranslationResponse: Decodable {
    public struct Key: Codable {
        public let id: String
        public let name: String
        public let plural: Bool?
    }

    public let id: String
    public let content: String
    public let unverified: Bool
    public let excluded: Bool
    public let pluralSuffix: String?
    public let key: Key
    public let locale: Locale
    public let placeholders: [String]
    public let state: String
    public let createdAt: Date
    public let updatedAt: Date?
    public let user: PhraseUser?
    public let wordCount: Int?
}
