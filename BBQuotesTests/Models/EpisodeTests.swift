//
//  EpisodeTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/10/19.
//

@testable import BBQuotes
import XCTest

final class EpisodeTests: XCTestCase {
    func testSeasonEpisodeComputation() {
        let episode = Episode(
            episode: 210,
            title: "Test",
            image: URL(string: "https://example.com")!,
            synopsis: "Test",
            writtenBy: "Test",
            directedBy: "Test",
            airDate: "01-01-2009"
        )

        XCTAssertEqual(Episode.mock.seasonEpisode, "Season 1 Episode 1")
        XCTAssertEqual(episode.seasonEpisode, "Season 2 Episode 10")
    }
}
