//
// Created by kacper on 03/08/2021.
//

import PhraseApi
import Vapor
import NIO

public extension Application {

    /// Shared instance of phrase
    var phrase: Phrase {
        .init(_app: self)
    }

    /// Phrase configuration error
    enum PhraseConfigError: Error {
        /// Phrase client wasn't configured therefore you can't use it
        case notConfigured
    }

    /// Phrase container for keeping shared instance of api client
    final class Phrase {
        let _app: Application

        init(_app: Application) {
            self._app = _app
        }

        private final class Storage {
            var client: PhraseClient?
            var defaultProject: PhraseClient.ProjectScope?
        }

        private struct Key: StorageKey {
            typealias Value = Storage
        }

        private var storage: Storage {
            if let existing = self._app.storage[Key.self] {
                return existing
            } else {
                let new = Storage()
                self._app.storage[Key.self] = new
                return new
            }
        }

        /// Configure Phrase API client shared instance
        ///
        /// - Parameters:
        ///   - token: Phrase OAuth token - you can generate it in Phrase web UI
        ///   - defaultProjectId: Optionally you can load default project scope to share it between calls
        /// - Returns: If you set token it returns empty future and you don't need to wait for it to finish.
        ///   If you set default project it will return empty future, but until it is fulfilled you won't be able to use default project.
        @discardableResult
        public func configure(token: String, defaultProjectId: String? = nil) -> EventLoopFuture<Void> {
            let client = PhraseClient(accessToken: token, httpClient: _app.http.client.shared, logger: _app.logger)
            storage.client = client

            guard let projectId = defaultProjectId else {
                return _app.eventLoopGroup.next().makeSucceededFuture(Void())
            }
            let futureProjectScope = client.project(id: projectId)
            return futureProjectScope.map { projectScope in
                self.storage.defaultProject = projectScope
                self._app.logger.debug("Loaded phrase project \(projectScope.projectData)")
            }
        }

        func logging(to newLogger: Logger) throws {
            guard let client = client else { throw PhraseConfigError.notConfigured }
            client.logging(to: newLogger)
        }

        /// PhraseAPI client shared instance
        ///
        /// - Important: You need to configure it before you can access it
        public var client: PhraseClient? {
            storage.client
        }

        /// PhraseAPI client shared project scope
        ///
        /// - Important: You need to configure it before you can access it
        public var project: PhraseClient.ProjectScope? {
            storage.defaultProject
        }
    }
}
