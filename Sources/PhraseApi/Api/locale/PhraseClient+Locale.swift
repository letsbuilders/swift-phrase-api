//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// API - locales
public extension PhraseClient.ProjectScope {
    /// List all locales
    ///
    /// - Returns: Future array of locales
    func locales() -> EventLoopFuture<[LocaleResponse]> {
        getMany(pathComponent: "locales", responseType: LocaleResponse.self, queryItems: [URLQueryItem(name: "sort_by", value: "default_asc")])
    }

    /// Get single locale
    ///
    /// - Parameter id: Id of locale you want to get
    /// - Returns: Future locale
    func locale(id: String) -> EventLoopFuture<LocaleResponse> {
        getOne(pathComponent: "locales", identifier: id, responseType: LocaleResponse.self)
    }

    /// Get default locale
    ///
    /// - Returns: Future locale if default one is set, if not `nil` will be returned.
    func defaultLocale() -> EventLoopFuture<LocaleResponse?> {
        locales().map { locales in locales.first { $0.default } }
    }
}