//
// Created by kacper on 29/07/2021.
//

import Foundation

public struct AccountResponse: Decodable {
	 let id: String
	 let name: String?
	 let slug: String?
	 let company: String?
	 let createdAt: Date?
	 let updatedAt: Date?
	 let companyLogoUrl: String?
}
