//
//  Death.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/15.
//

import Foundation

struct Death: Decodable, Equatable {
    let character: String
    let image: URL
    let details: String
    let lastWords: String
}
