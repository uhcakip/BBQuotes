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

    func testFetchCharacterBadResponse() async {
        mockSession.response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)

        do {
            _ = try await sut.fetchCharacter("Walter White")
            XCTFail("Expected badResponse error")
        } catch {
            let error = error as? APIError
            XCTAssertEqual(error, .badResponse)
            XCTAssertEqual(error?.rawValue, "Something went wrong. Please try again later.")
        }
    }

    func testFetchDeathBadResponse() async {
        mockSession.response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)

        do {
            _ = try await sut.fetchDeath(for: "White")
            XCTFail("Expected badResponse error")
        } catch {
            let error = error as? APIError
            XCTAssertEqual(error, .badResponse)
            XCTAssertEqual(error?.rawValue, "Something went wrong. Please try again later.")
        }
    }
}
