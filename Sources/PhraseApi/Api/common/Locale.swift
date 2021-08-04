//
// Created by Kacper Kawecki on 28/07/2021.
//

import Foundation

public struct Locale: Decodable {
    public let id: String
    public let name: String?
    public let code: String?
}
