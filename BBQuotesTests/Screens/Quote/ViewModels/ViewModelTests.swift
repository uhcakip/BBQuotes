//
//  ViewModelTests.swift
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
    var errorToThrow: Error?

    func fetchQuote(from _: Production) async throws -> Quote {
        if let error = errorToThrow { throw error }
        return quoteToReturn ?? Quote(quote: "", character: "")
    }

    func fetchCharacter(_ name: String) async throws -> Character? {
        if let error = errorToThrow { throw error }
        return characterToReturn ?? Character(
            name: name,
            birthday: "",
            occupations: [],
            images: [],
            aliases: [],
            status: "",
            portrayedBy: ""
        )
    }

    func fetchDeath(for _: String) async throws -> Death? {
        if let error = errorToThrow { throw error }
        return deathToReturn
    }
}

class ViewModelTests: XCTestCase {
    private var sut: ViewModel!
    private var mockClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient()
        sut = ViewModel(client: mockClient)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockClient = nil
    }

    func testFetchDataSuccess() async {
        let expectedQuote = Quote(quote: "I am the one who knocks", character: "Walter White")
        var expectedCharacter = Character(
            name: "Walter White",
            birthday: "09-07-1958",
            occupations: ["Chemistry Teacher", "Meth King Pin"],
            images: [URL(string: "https://example.com/walter.jpg")!],
            aliases: ["Heisenberg"],
            status: "Deceased",
            portrayedBy: "Bryan Cranston"
        )
        let expectedDeath = Death(
            character: "Walter White",
            image: URL(string: "https://example.com/walter_death.jpg")!,
            details: "Shot",
            lastWords: "I did it for me. I liked it."
        )

        mockClient.quoteToReturn = expectedQuote
        mockClient.characterToReturn = expectedCharacter
        mockClient.deathToReturn = expectedDeath
        expectedCharacter.death = expectedDeath

        await sut.fetchData(for: .breakingBad)

        XCTAssertEqual(sut.fetchStatus, ViewModel.DataFetchStatus.success)
        XCTAssertEqual(sut.quote, expectedQuote)
        XCTAssertEqual(sut.character, expectedCharacter)
    }

    func testFetchDataFailure() async {
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockClient.errorToThrow = expectedError

        await sut.fetchData(for: .breakingBad)

        XCTAssertTrue(sut.fetchStatus == .failure(error: expectedError))
        XCTAssertNil(sut.quote)
        XCTAssertNil(sut.character)
    }
}
