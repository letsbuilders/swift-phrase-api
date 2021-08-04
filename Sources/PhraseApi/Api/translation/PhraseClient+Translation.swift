//
// Created by Kacper Kawecki on 30/07/2021.
//

import Foundation
import NIO

// Api - translations
public extension PhraseClient.ProjectScope {
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

    /// List all translations for the given key
    ///
    /// - Parameters:
    ///   - keyId: Key identifier
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future array of translations
    ///
    /// - SeeAlso: `TranslationResponse`,
    func translations(keyId: String, branch: String? = nil) -> EventLoopFuture<[TranslationResponse]> {
        translations(pathComponents: ["keys", keyId, "translations"], branch: branch)
    }

    /// List all translations for the given locale
    ///
    /// - Parameters:
    ///   - localeName: Locale name
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future array of translations
    ///
    /// - SeeAlso: `TranslationResponse`
    func translations(localeName: String, branch: String? = nil) -> EventLoopFuture<[TranslationResponse]> {
        translations(pathComponents: ["locales", localeName, "translations"], branch: branch)
    }

    /// List all translations in a project
    ///
    /// - Parameters:
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future array of translations
    ///
    /// - SeeAlso: `TranslationResponse`
    func translations(branch: String? = nil) -> EventLoopFuture<[TranslationResponse]> {
        translations(pathComponents: ["translations"], branch: branch)
    }

    /// Get single translation
    ///
    /// - Parameters:
    ///   - id: Translation id
    ///   - branch: Specify the branch to use (optional)
    /// - Returns: Future translation
    ///
    /// - SeeAlso: `TranslationResponse`
    func translation(id: String, branch: String? = nil) -> EventLoopFuture<TranslationResponse> {
        var queryItems: [URLQueryItem]? = nil
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        }

        return getOne(pathComponent: "translations", identifier: id, responseType: TranslationResponse.self, queryItems: queryItems)
    }

    /// Create new translation
    ///
    /// - Parameter translation: Translation data
    /// - Returns: Future translation
    func createTranslation(_ translation: TranslationRequest) -> EventLoopFuture<TranslationResponse> {
        createOne(pathComponent: "translations", requestData: translation, responseType: TranslationResponse.self)
    }

    /// Create new translation
    ///
    /// - Parameters:
    ///   - localeId: Locale. Can be the name or public id of the locale. Preferred is the public id.
    ///   - keyid: Key id for which translation will be created
    ///   - content: Translated content
    ///   - branch: Specify the branch to use (optional)
    ///   - pluralSuffix: Plural suffix. Can be one of: `.zero`, `.one`, `.two`, `.few`, `.many`, `.other`. Must be specified if the key associated to the translation is pluralized.
    ///   - autotranslate: Indicates whether the translation should be auto-translated.
    ///         Fails with status 422 if provided for translation within a non-default locale or the project does not have the Autopilot feature enabled.
    /// - Returns: Future translation
    func createTranslation(localeId: String, keyid: String, content: String, branch: String?, pluralSuffix: PhrasePluralSuffix? = nil, autotranslate: Bool? = true) -> EventLoopFuture<TranslationResponse> {
        let translation = TranslationRequest(branch: branch, localeId: localeId, keyId: keyid, content: content, pluralSuffix: pluralSuffix, unverified: true, excluded: nil, autotranslate: autotranslate)
        return createTranslation(translation)
    }

    /// Update existing translation
    ///
    /// - Parameters:
    ///   - id: Id of translation
    ///   - translationRequest: Translation data to update (nil values will be omitted)
    /// - Returns:
    func updateTranslation(id: String, changes translationRequest: TranslationRequest) -> EventLoopFuture<TranslationResponse> {
        var data = translationRequest
        // Don't send this keys
        data.keyId = nil
        data.localeId = nil

        return updateOne(pathComponent: "translations", identifier: id, requestData: data, responseType: TranslationResponse.self)
    }
}
