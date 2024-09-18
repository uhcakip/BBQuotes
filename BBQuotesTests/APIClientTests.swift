//
//  APIClientTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/9/18.
//

@testable import BBQuotes
import XCTest

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(from _: URL) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}

final class APIClientTests: XCTestCase {
    private var mockSession: MockURLSession!
    private var sut: APIClient!
    private let url = URL(string: "https://example.com")!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = APIClient(session: mockSession)
    }

    override func tearDown() {
        super.tearDown()
        mockSession = nil
        sut = nil
    }

    func testFetchQuotesSuccess() async throws {
        let mockQuote = Quote(quote: "I am the one who knocks", character: "Walter White")
        let mockData = try JSONEncoder().encode(mockQuote)
        mockSession.data = mockData
        mockSession.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        let result = try await sut.fetchQuote(from: .breakingBad)

        XCTAssertEqual(result.quote, mockQuote.quote)
        XCTAssertEqual(result.character, mockQuote.character)
    }

    func testFetchQuotesBadResponse() async {
        mockSession.response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)

        do {
            _ = try await sut.fetchQuote(from: .breakingBad)
            XCTFail("Expected badResponse error")
        } catch {
            let error = error as? APIError
            XCTAssertEqual(error, .badResponse)
            XCTAssertEqual(error?.rawValue, "Something went wrong. Please try again later.")
        }
    }
}
