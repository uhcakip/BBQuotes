//
//  APIClientIntegrationTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/9/18.
//

@testable import BBQuotes
import XCTest

final class APIClientIntegrationTests: XCTestCase {
    func testFetchQuotesIntegration() async throws {
        let client = APIClient()
        let quote = try await client.fetchQuote(from: .breakingBad)

        XCTAssertFalse(quote.quote.isEmpty)
        XCTAssertFalse(quote.character.isEmpty)
    }
}
