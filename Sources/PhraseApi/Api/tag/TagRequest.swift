//
// Created by Kacper Kawecki on 28/07/2021.
//

import Foundation

public struct TagRequest: Encodable {
    let branch: String?
    let name: String
}
