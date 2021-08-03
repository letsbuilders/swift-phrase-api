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
}
