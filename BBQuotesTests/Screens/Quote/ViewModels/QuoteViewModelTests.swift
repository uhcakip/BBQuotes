//
//  QuoteViewModelTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/9/23.
//

@testable import BBQuotes
import XCTest

class MockAPIClient: APIClientProtocol {
    var quote: Quote?
    var character: Character?
    var death: Death?
    var episode: Episode?
    var error: Error?

    func fetchQuote(from _: Production) async throws -> Quote {
        if let error { throw error }
        return quote ?? Quote(quote: "", character: "")
    }

    func fetchCharacter(_: String) async throws -> Character? {
        if let error { throw error }
        return character
    }

    func fetchDeath(for _: String) async throws -> Death? {
        if let error { throw error }
        return death
    }

    func fetchEpisode(from _: Production) async throws -> Episode? {
        if let error { throw error }
        return episode
    }
}

class QuoteViewModelTests: XCTestCase {
    private var sut: QuoteViewModel!
    private var mockClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient()
        sut = QuoteViewModel(client: mockClient)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockClient = nil
    }

    func testFetchDataSuccess() async {
        let expectedQuote = Quote.mock
        var expectedCharacter = Character.mock
        let expectedDeath = Death.mock

        mockClient.quote = expectedQuote
        mockClient.character = expectedCharacter
        mockClient.death = expectedDeath
        expectedCharacter.death = expectedDeath

        await sut.fetchQuoteData(for: .breakingBad)

        XCTAssertEqual(String(describing: sut.fetchStatus), String(describing: QuoteViewModel.DataFetchStatus.success))
        XCTAssertEqual(sut.quote, expectedQuote)
        XCTAssertEqual(sut.character, expectedCharacter)
    }

    func testFetchDataFailure() async {
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockClient.error = expectedError

        await sut.fetchQuoteData(for: .breakingBad)

        if case let .failure(error) = sut.fetchStatus {
            XCTAssertEqual(error as NSError, expectedError)
        } else {
            XCTFail("Expected .failure status, but got \(sut.fetchStatus)")
        }

        XCTAssertNil(sut.quote)
        XCTAssertNil(sut.character)
    }

    func testFetchEpisodeDataSuccess() async {
        let expectedEpisode = Episode.mock
        mockClient.episode = expectedEpisode

        await sut.fetchEpisodeData(for: .breakingBad)

        XCTAssertEqual(String(describing: sut.fetchStatus), String(describing: QuoteViewModel.DataFetchStatus.success))
        XCTAssertEqual(sut.episode, expectedEpisode)
    }

    func testFetchEpisodeDataFailure() async {
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockClient.error = expectedError

        await sut.fetchEpisodeData(for: .breakingBad)

        if case let .failure(error) = sut.fetchStatus {
            XCTAssertEqual(error as NSError, expectedError)
        } else {
            XCTFail("Expected .failure status, but got \(sut.fetchStatus)")
        }

        XCTAssertNil(sut.episode)
    }
}
