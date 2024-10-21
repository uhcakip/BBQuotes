//
//  EpisodeView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/10/22.
//

import SwiftUI

struct EpisodeView: View {
    let episode: Episode?

    var body: some View {
        if let episode {
            VStack(alignment: .leading) {
                Text(episode.title)
                    .font(.title)

                Text(episode.seasonEpisode)
                    .font(.title2)

                AsyncImage(url: episode.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.bottom, 10)
                } placeholder: {
                    ProgressView()
                }

                Text(episode.synopsis)
                    .font(.title3)
                    .minimumScaleFactor(0.5)
                    .padding(.bottom)

                Text("Written by: \(episode.writtenBy)")

                Text("Directed by: \(episode.directedBy)")

                Text("Air Date: \(episode.airDate)")
            }
            .padding()
            .foregroundStyle(.white)
            .background(.black.opacity(0.6))
            .clipShape(.rect(cornerRadius: 25))
            .padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    EpisodeView(episode: Episode.mock)
}
