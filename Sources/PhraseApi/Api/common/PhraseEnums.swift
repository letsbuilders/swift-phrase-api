//
// Created by Kacper Kawecki on 20/04/2021.
//

import Foundation

public enum PhrasePluralSuffix: String, Codable {
    case zero, one, two, few, many, other
}

public enum PhraseDataType: String, Codable {
    case string, number, boolean, array, markdown
}
