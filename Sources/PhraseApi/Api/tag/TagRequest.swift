//
// Created by Kacper Kawecki on 28/07/2021.
//

import Foundation

public struct TagRequest: Encodable {
    public let branch: String?
    public let name: String
}
