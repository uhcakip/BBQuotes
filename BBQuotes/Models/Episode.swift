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
        var episode = String(self.episode)
        let season = episode.removeFirst()
        if episode.prefix(1) == "0" {
            episode = String(episode.removeLast())
        }
        return "Season \(season) Episode \(episode)"
    }
}
