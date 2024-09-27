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
    func fetchCharacter(_ name: String) async throws -> Character
    func fetchDeath(for name: String) async throws -> Death?
}

struct APIClient: APIClientProtocol {
    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func fetchQuote(from production: Production) async throws -> Quote {
        let url = APIEndpoint.quotes.url
            .appending(queryItems: [.init(name: "production", value: production.rawValue)])

        let (data, resp) = try await session.data(from: url)

        guard let resp = resp as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.badResponse
        }

        return try decoder.decode(Quote.self, from: data)
    }

    func fetchCharacter(_ name: String) async throws -> Character {
        let url = APIEndpoint.characters.url
            .appending(queryItems: [.init(name: "name", value: name)])

        let (data, resp) = try await session.data(from: url)

        guard let resp = resp as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.badResponse
        }

        let characters = try decoder.decode([Character].self, from: data)
        return characters[0]
    }

    func fetchDeath(for character: String) async throws -> Death? {
        let url = APIEndpoint.deaths.url
        let (data, resp) = try await session.data(from: url)

        guard let resp = resp as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.badResponse
        }

        let deaths = try decoder.decode([Death].self, from: data)
        return deaths.first { $0.character == character }
    }
}

enum APIError: String, Error {
    case badResponse = "Something went wrong. Please try again later."
}
