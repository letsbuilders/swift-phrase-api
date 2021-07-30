//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// Api - translations
extension PhraseClient.ProjectScope {
    private func translations(pathComponents: [String], branch: String?) -> EventLoopFuture<[TranslationResponse]> {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "sort", value: "created_at"),
            URLQueryItem(name: "order", value: "asc")
        ]
        if let branch = branch {
            queryItems.append(URLQueryItem(name: "branch", value: branch))
        }

        return getMany(pathComponents: pathComponents, responseType: TranslationResponse.self, queryItems: [URLQueryItem(name: "sort_by", value: "name")])
    }

    func translations(keyId: String, branch: String? = nil) -> EventLoopFuture<[TranslationResponse]> {
        translations(pathComponents: ["keys", keyId, "translations"], branch: branch)
    }

    func translations(localeId: String, branch: String? = nil) -> EventLoopFuture<[TranslationResponse]> {
        translations(pathComponents: ["locales", localeId, "translations"], branch: branch)
    }

    func translations(branch: String? = nil) -> EventLoopFuture<[TranslationResponse]> {
        translations(pathComponents: ["translations"], branch: branch)
    }

    func translations(id: String, branch: String? = nil) -> EventLoopFuture<TranslationResponse> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return getOne(pathComponent: "translations", identifier: id, responseType: TranslationResponse.self, queryItems: queryItems)
    }

    func createTranslation(localeId: String, keyid: String, content: String, branch: String?, pluralSuffix: PhrasePluralSuffix? = nil) -> EventLoopFuture<TranslationResponse> {
        let requestData = TranslationRequest(branch: branch, localeId: localeId, keyId: keyid, content: content, pluralSuffix: pluralSuffix, unverified: nil, excluded: nil, autotranslate: true)
        return createOne(pathComponent: "translations", requestData: requestData, responseType: TranslationResponse.self)
    }
}
