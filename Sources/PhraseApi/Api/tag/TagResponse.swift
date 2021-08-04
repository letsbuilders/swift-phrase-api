//
// Created by Kacper Kawecki on 28/07/2021.
//

import Foundation

public struct TagResponse: Decodable {
    public struct Statistic: Decodable {
        public let keysTotalCount: Int
        public let translationsCompletedCount: Int
        public let translationsUnverifiedCount: Int
        public let keysUntranslatedCount: Int
    }

    public struct LocaleStatistic: Decodable {
        public let locale: Locale
        public let statistics: Statistic?
    }

    public let name: String
    public let keyCount: Int?
    public let createdAt: Date?
    public let updatedAt: Date?
    public let statistics: [LocaleStatistic]?
}
