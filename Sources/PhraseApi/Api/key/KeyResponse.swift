//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct KeyResponse: Decodable {
    public let id: String
    public let branch: String?
    public let name: String
    public let nameHash: String
    public let description: String?
    public let plural: Bool?
    public let namePlural: String?
    public let dataType: PhraseDataType?
    public let createdAt: Date
    public let updatedAt: Date?
    public let tags: [String]?
    public let commentsCount: Int?
    public let maxCharactersAllowed: Int?
    public let screenshotUrl: String?
    public let unformatted: Bool?
    public let xmlSpacePreserve: Bool?
    public let originalFile: String?
    public let formatValueType: String?
    public let creator: PhraseUser?
}
