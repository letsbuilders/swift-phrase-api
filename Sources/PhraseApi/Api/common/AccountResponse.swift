//
// Created by kacper on 29/07/2021.
//

import Foundation

public struct AccountResponse: Decodable {
	 public let id: String
	 public let name: String?
	 public let slug: String?
	 public let company: String?
	 public let createdAt: Date?
	 public let updatedAt: Date?
	 public let companyLogoUrl: String?
}
