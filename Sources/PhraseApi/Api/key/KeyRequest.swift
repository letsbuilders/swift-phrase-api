//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct KeyRequest: Encodable {
    public let branch: String?
    public let name: String
    public let description: String?
    public let plural: Bool?
    public let namePlural: String?
    public let dataType: PhraseDataType
    public let tags: String?
    public let maxCharactersAllowed: Int?
    public let unformatted: Bool?
    public let xmlSpacePreserve: Bool?
    public let originalFile: String?
    public let localizedFormatString: String?
    public let localizedFormatKey: String?

    public init(
            branch: String? = nil,
            name: String,
            description: String? = nil,
            plural: Bool? = nil,
            namePlural: String? = nil,
            dataType: PhraseDataType,
            tags: String? = nil,
            maxCharactersAllowed: Int? = nil,
            unformatted: Bool? = nil,
            xmlSpacePreserve: Bool? = nil,
            originalFile: String? = nil,
            localizedFormatString: String? = nil,
            localizedFormatKey: String? = nil
    ) {
        self.branch = branch
        self.name = name
        self.description = description
        self.plural = plural
        self.namePlural = namePlural
        self.dataType = dataType
        self.tags = tags
        self.maxCharactersAllowed = maxCharactersAllowed
        self.unformatted = unformatted
        self.xmlSpacePreserve = xmlSpacePreserve
        self.originalFile = originalFile
        self.localizedFormatString = localizedFormatString
        self.localizedFormatKey = localizedFormatKey
    }
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
