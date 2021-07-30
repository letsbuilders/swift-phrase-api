//
// Created by kacper on 29/07/2021.
//

import Foundation

public struct SpaceResponse: Decodable {
	 let id: String
	 let name: String?
	 let createdAt: Date?
	 let updatedAt: Date?
	 let projectsCount: Int
}
