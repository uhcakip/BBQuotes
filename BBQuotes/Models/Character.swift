//
//  Character.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/15.
//

import Foundation

struct Character: Decodable, Equatable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death?
}
