//
// Created by Kacper Kawecki on 28/07/2021.
//

import Foundation

public struct TagResponse: Decodable {
    public struct Statistic: Decodable {
        let keys_total_count: Int
        let translations_completed_count: Int
        let translations_unverified_count: Int
        let keys_untranslated_count: Int
    }

    public struct LocaleStatistic: Decodable {
        let locale: Locale
        let statistics: Statistic
    }

    let name: String
    let keyCount: Int
    let createdAt: Date
    let updatedAt: Date?
    let statistics: [LocaleStatistic]
}
