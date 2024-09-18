//
//  APIEndpointTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/9/18.
//

@testable import BBQuotes
import XCTest

final class APIEndpointTests: XCTestCase {
    private let baseURL = "https://breaking-bad-api-six.vercel.app/api"

    func testURL() {
        let quotesURL = APIEndpoint.quotes.url
        let charactersURL = APIEndpoint.characters.url
        let deathsURL = APIEndpoint.deaths.url

        XCTAssertEqual(quotesURL.absoluteString, "\(baseURL)/quotes/random")
        XCTAssertEqual(charactersURL.absoluteString, "\(baseURL)/characters")
        XCTAssertEqual(deathsURL.absoluteString, "\(baseURL)/deaths")
    }
}
