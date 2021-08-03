import XCTest
@testable import PhraseApi

final class PhraseApiTests: XCTestCase {
    func testClientInitialisation() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let client = PhraseClient(accessToken: "xyz")
        XCTAssertEqual(client.userAgent, "Swift Phrase API wrapper")
        XCTAssertNotNil(client.logger)
    }
}
