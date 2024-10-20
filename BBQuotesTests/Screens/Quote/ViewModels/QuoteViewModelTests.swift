//
//  QuoteViewModelTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/9/23.
//

@testable import BBQuotes
import XCTest

class MockAPIClient: APIClientProtocol {
    var quoteToReturn: Quote?
    var characterToReturn: Character?
    var deathToReturn: Death?
    var episodeToReturn: Episode?
    var errorToThrow: Error?

    func fetchQuote(from _: Production) async throws -> Quote {
        if let error = errorToThrow { throw error }
        return quoteToReturn ?? Quote(quote: "", character: "")
    }

    func fetchCharacter(_: String) async throws -> Character? {
        if let error = errorToThrow { throw error }
        return characterToReturn
    }

    func fetchDeath(for _: String) async throws -> Death? {
        if let error = errorToThrow { throw error }
        return deathToReturn
    }

    func fetchEpisode(from _: Production) async throws -> Episode? {
        if let error = errorToThrow { throw error }
        return episodeToReturn
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

        mockClient.quoteToReturn = expectedQuote
        mockClient.characterToReturn = expectedCharacter
        mockClient.deathToReturn = expectedDeath
        expectedCharacter.death = expectedDeath

        await sut.fetchQuoteData(for: .breakingBad)

        XCTAssertEqual(String(describing: sut.fetchStatus), String(describing: QuoteViewModel.DataFetchStatus.success))
        XCTAssertEqual(sut.quote, expectedQuote)
        XCTAssertEqual(sut.character, expectedCharacter)
    }

    func testFetchDataFailure() async {
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockClient.errorToThrow = expectedError

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
        mockClient.episodeToReturn = expectedEpisode

        await sut.fetchEpisodeData(for: .breakingBad)

        XCTAssertEqual(String(describing: sut.fetchStatus), String(describing: QuoteViewModel.DataFetchStatus.success))
        XCTAssertEqual(sut.episode, expectedEpisode)
    }

    func testFetchEpisodeDataFailure() async {
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockClient.errorToThrow = expectedError

        await sut.fetchEpisodeData(for: .breakingBad)

        if case let .failure(error) = sut.fetchStatus {
            XCTAssertEqual(error as NSError, expectedError)
        } else {
            XCTFail("Expected .failure status, but got \(sut.fetchStatus)")
        }

        XCTAssertNil(sut.episode)
    }
}
