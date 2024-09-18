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

struct APIClient {
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
}

enum Production: String {
    case breakingBad = "Breaking Bad"
    case betterCallSaul = "Better Call Saul"
}

enum APIError: String, Error {
    case badResponse = "Something went wrong. Please try again later."
}
