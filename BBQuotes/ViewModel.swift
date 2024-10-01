//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/23.
//

import Foundation

@Observable class ViewModel {
    enum DataFetchStatus: Equatable {
        case idle
        case fetching
        case success
        case failure(error: Error)

        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle), (.fetching, .fetching), (.success, .success):
                true
            case let (.failure(error1), .failure(error2)):
                error1.localizedDescription == error2.localizedDescription
            default:
                false
            }
        }
    }

    let client: APIClientProtocol
    var quote: Quote?
    var character: Character?
    var fetchStatus = DataFetchStatus.idle

    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }

    func fetchData(for production: Production) async {
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
}
