//
//  APIClient.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/17.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol APIClientProtocol {
    func fetchQuote(from production: Production) async throws -> Quote
    func fetchCharacter(_ name: String) async throws -> Character?
    func fetchDeath(for name: String) async throws -> Death?
    func fetchEpisode(from production: Production) async throws -> Episode?
}

enum Endpoint {
    private static let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    static let quotes = baseURL.appending(path: "quotes/random")
    static let characters = baseURL.appending(path: "characters")
    static let deaths = baseURL.appending(path: "deaths")
    static let episodes = baseURL.appending(path: "episodes")
}

struct APIClient: APIClientProtocol {
    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    private func makeRequest<T: Decodable>(from url: URL) async throws -> T {
        let (data, resp) = try await session.data(from: url)

        guard let resp = resp as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.badResponse
        }

        return try decoder.decode(T.self, from: data)
    }

    func fetchQuote(from production: Production) async throws -> Quote {
        let url = Endpoint.quotes.appending(queryItems: [.init(name: "production", value: production.rawValue)])
        return try await makeRequest(from: url)
    }

    func fetchCharacter(_ name: String) async throws -> Character? {
        let url = Endpoint.characters.appending(queryItems: [.init(name: "name", value: name)])
        let characters: [Character] = try await makeRequest(from: url)
        return characters.first
    }

    func fetchDeath(for character: String) async throws -> Death? {
        let url = Endpoint.deaths
        let deaths: [Death] = try await makeRequest(from: url)
        return deaths.first { $0.character == character }
    }

    func fetchEpisode(from production: Production) async throws -> Episode? {
        let url = Endpoint.episodes.appending(queryItems: [.init(name: "production", value: production.rawValue)])
        let episodes: [Episode] = try await makeRequest(from: url)
        return episodes.randomElement()
    }
}

enum APIError: Error {
    case badResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badResponse:
            "Something went wrong. Please try again later."
        }
    }
}
