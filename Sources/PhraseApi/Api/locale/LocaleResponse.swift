//
//  LocaleResponse.swift
//  PhraseTests
//
//  Created by Kacper Kawecki on 30/07/2021.
//

import Foundation

public struct LocaleResponse: Decodable {
    public let id: String
    public let name: String
    public let code: String
    public let `default`: Bool
    public let main: Bool
    public let rtl: Bool
    public let pluralForms: [String]?
    public let sourceLocale: Locale?
    public let createdAt: Date
    public let updatedAt: Date?
}
