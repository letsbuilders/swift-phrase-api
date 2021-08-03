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

        return getMany(pathComponents: pathComponents, responseType: TranslationResponse.self, queryItems: queryItems)
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

    func createTranslation(_ translation: TranslationRequest) -> EventLoopFuture<TranslationResponse> {
        createOne(pathComponent: "translations", requestData: translation, responseType: TranslationResponse.self)
    }

    func createTranslation(localeId: String, keyid: String, content: String, branch: String?, pluralSuffix: PhrasePluralSuffix? = nil, autotranslate: Bool? = true) -> EventLoopFuture<TranslationResponse> {
        let translation = TranslationRequest(branch: branch, localeId: localeId, keyId: keyid, content: content, pluralSuffix: pluralSuffix, unverified: true, excluded: nil, autotranslate: autotranslate)
        return createTranslation(translation)
    }

    func updateTranslation(id: String, changes translationRequest: TranslationRequest) -> EventLoopFuture<TranslationResponse> {
        var data = translationRequest
        // Don't send this keys
        data.keyId = nil
        data.localeId = nil

        return updateOne(pathComponent: "translations", identifier: id, requestData: data, responseType: TranslationResponse.self)
    }
}
