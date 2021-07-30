//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct KeyResponse: Decodable {
    let id: String
    let branch: String?
    let name: String
    let nameHash: String
    let description: String?
    let plural: Bool?
    let namePlural: String?
    let dataType: PhraseDataType?
    let createdAt: Date
    let updatedAt: Date?
    let tags: [String]?
    let commentsCount: Int?
    let maxCharactersAllowed: Int?
    let screenshotUrl: String?
    let unformatted: Bool?
    let xmlSpacePreserve: Bool?
    let originalFile: String?
    let formatValueType: String?
    let creator: PhraseUser?
}
