//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public struct TranslationRequest: Codable {
    let branch: String?
    let localeId: String?
    let keyId: String?
    let content: String
    let pluralSuffix: PhrasePluralSuffix?
    let unverified: Bool?
    let excluded: Bool?
    let autotranslate: Bool?
}
