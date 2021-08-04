//
// Created by kacper on 29/07/2021.
//

import Foundation

public struct SpaceResponse: Decodable {
	 public let id: String
	 public let name: String?
	 public let createdAt: Date?
	 public let updatedAt: Date?
	 public let projectsCount: Int
}
