//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct TranslationRequest: Encodable {
    let branch: String?
    var localeId: String?
    var keyId: String?
    let content: String
    let pluralSuffix: PhrasePluralSuffix?
    let unverified: Bool?
    let excluded: Bool?
    let autotranslate: Bool?

    public init(branch: String? = nil, localeId: String? = nil, keyId: String? = nil, content: String, pluralSuffix: PhrasePluralSuffix? = nil, unverified: Bool? = nil, excluded: Bool? = nil, autotranslate: Bool? = nil) {
        self.branch = branch
        self.localeId = localeId
        self.keyId = keyId
        self.content = content
        self.pluralSuffix = pluralSuffix
        self.unverified = unverified
        self.excluded = excluded
        self.autotranslate = autotranslate
    }
}
