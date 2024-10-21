//
//  QuoteEpisodeViewModel.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/23.
//

import Foundation

@Observable class QuoteEpisodeViewModel {
    enum DataFetchStatus {
        case idle
        case fetching
        case success
        case failure(error: Error)
    }

    private let client: APIClientProtocol
    var quote: Quote?
    var character: Character?
    var episode: Episode?
    var fetchStatus = DataFetchStatus.idle

    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }

    func fetchQuoteData(for production: Production) async {
        fetchStatus = .fetching
        do {
            quote = try await client.fetchQuote(from: production)
            if let characterName = quote?.character {
                character = try await client.fetchCharacter(characterName)
                character?.death = try await client.fetchDeath(for: characterName)
            }
            fetchStatus = .success
        } catch {
            fetchStatus = .failure(error: error)
        }
    }

    func fetchEpisodeData(for production: Production) async {
        fetchStatus = .fetching
        do {
            episode = try await client.fetchEpisode(from: production)
            fetchStatus = .success
        } catch {
            fetchStatus = .failure(error: error)
        }
    }
}
