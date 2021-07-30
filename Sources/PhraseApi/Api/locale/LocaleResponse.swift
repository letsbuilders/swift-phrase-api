//
//  LocaleResponse.swift
//  PhraseTests
//
//  Created by Kacper Kawecki on 30/07/2021.
//

import Foundation

public struct LocaleResponse: Decodable {
    let id: String
    let name: String
    let code: String
    let `default`: Bool
    let main: Bool
    let rtl: Bool
    let pluralForms: [String]?
    let sourceLocale: Locale?
    let createdAt: Date
    let updatedAt: Date?
}
