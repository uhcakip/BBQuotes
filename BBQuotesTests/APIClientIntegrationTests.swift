//
//  APIClientIntegrationTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/9/18.
//

@testable import BBQuotes
import XCTest

final class APIClientIntegrationTests: XCTestCase {
    private var client = APIClient()
    private let characterName = "Walter White"

    func testFetchQuotesIntegration() async throws {
        let quote = try await client.fetchQuote(from: .breakingBad)

        XCTAssertFalse(quote.quote.isEmpty)
        XCTAssertFalse(quote.character.isEmpty)
    }

    func testFetchCharacterIntegration() async throws {
        let character = try await client.fetchCharacter(characterName)

        XCTAssertEqual(character.name, characterName)
        XCTAssertEqual(character.birthday, "09-07-1958")
        XCTAssertFalse(character.occupations.isEmpty)
        XCTAssertFalse(character.images.isEmpty)
        XCTAssertFalse(character.aliases.isEmpty)
        XCTAssertEqual(character.status, "Dead")
        XCTAssertEqual(character.portrayedBy, "Bryan Cranston")
        XCTAssertNil(character.death)
    }

    func testFetchDeathIntegration() async throws {
        let death = try await client.fetchDeath(for: characterName)
        guard let death else {
            XCTFail("Death should not be nil")
            return
        }

        XCTAssertEqual(death.character, characterName)
        XCTAssertFalse(death.image.absoluteString.isEmpty)
        XCTAssertFalse(death.details.isEmpty)
        XCTAssertFalse(death.lastWords.isEmpty)
    }
}
