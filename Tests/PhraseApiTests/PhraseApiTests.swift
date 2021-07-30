    import XCTest
    @testable import PhraseApi

    final class PhraseApiTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            XCTAssertEqual(PhraseClient(accessToken: "").userAgent, "Swift Phrase API wrapper")
        }
    }
