//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// API - locales
public extension PhraseClient.ProjectScope {
    func locales() -> EventLoopFuture<[LocaleResponse]> {
        getMany(pathComponent: "locales", responseType: LocaleResponse.self, queryItems: [URLQueryItem(name: "sort_by", value: "default_asc")])
    }

    func locale(id: String) -> EventLoopFuture<LocaleResponse> {
        getOne(pathComponent: "locales", identifier: id, responseType: LocaleResponse.self)
    }

    func defaultLocale() -> EventLoopFuture<LocaleResponse?> {
        locales().map { locales in locales.first { $0.default } }
    }
}