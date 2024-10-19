//
//  Episode.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/10/18.
//

import Foundation

struct Episode: Decodable, Equatable {
    let episode: Int
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let directedBy: String
    let airDate: String

    var seasonEpisode: String {
        let season = episode / 100
        let episode = episode % 100
        return "Season \(season) Episode \(episode)"
    }
}
