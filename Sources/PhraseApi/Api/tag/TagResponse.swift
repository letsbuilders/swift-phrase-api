//
// Created by Kacper Kawecki on 28/07/2021.
//

import Foundation

public struct TagResponse: Decodable {
    public struct Statistic: Decodable {
        let keysTotalCount: Int
        let translationsCompletedCount: Int
        let translationsUnverifiedCount: Int
        let keysUntranslatedCount: Int
    }

    public struct LocaleStatistic: Decodable {
        let locale: Locale
        let statistics: Statistic?
    }

    let name: String
    let keyCount: Int?
    let createdAt: Date?
    let updatedAt: Date?
    let statistics: [LocaleStatistic]?
}
