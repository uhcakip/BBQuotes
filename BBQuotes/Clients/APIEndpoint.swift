//
//  APIEndpoint.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/17.
//

import Foundation

enum APIEndpoint: String {
    case quotes
    case characters
    case deaths

    var url: URL {
        let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!

        switch self {
        case .quotes:
            return baseURL.appending(path: "quotes/random")
        case .characters:
            return baseURL.appending(path: "characters")
        case .deaths:
            return baseURL.appending(path: "deaths")
        }
    }
}
