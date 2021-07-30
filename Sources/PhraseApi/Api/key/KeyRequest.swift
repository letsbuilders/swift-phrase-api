//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct KeyRequest: Codable {
    let branch: String?
    let name: String
    let description: String?
    let plural: Bool?
    let namePlural: String?
    let dataType: PhraseDataType
    let tags: String?
    let maxCharactersAllowed: Int?
    let unformatted: Bool?
    let xmlSpacePreserve: Bool?
    let originalFile: String?
    let localizedFormatString: String?
    let localizedFormatKey: String?
}

public extension KeyRequest {
    init(branch: String?, name: String, description: String? = nil, dataType: PhraseDataType = .string, tags tagsArray: [String]? = nil, maxCharactersAllowed: Int? = nil) {
        var tags: String?
        if let tagsArray = tagsArray {
            tags = tagsArray.joined(separator: ",")
        }
        self.branch = branch
        self.name = name
        self.description = description
        self.dataType = dataType
        self.tags = tags
        self.maxCharactersAllowed = maxCharactersAllowed
        self.plural = false
        self.namePlural = nil
        self.unformatted = nil
        self.xmlSpacePreserve = nil
        self.originalFile = nil
        self.localizedFormatString = nil
        self.localizedFormatKey = nil
    }
}
