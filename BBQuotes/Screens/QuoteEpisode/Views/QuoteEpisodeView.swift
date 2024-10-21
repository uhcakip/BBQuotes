//
//  QuoteEpisodeView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/23.
//

import SwiftUI

struct QuoteEpisodeView: View {
    // MARK: - Variables

    let production: Production
    let viewModel: QuoteEpisodeViewModel
    @State private var showCharacterView = false

    init(production: Production, viewModel: QuoteEpisodeViewModel = QuoteEpisodeViewModel()) {
        self.production = production
        self.viewModel = viewModel

        Task {
            await viewModel.fetchQuoteData(for: production)
        }
    }

    // MARK: - Views

    private func backgroundImage(geoSize size: CGSize) -> some View {
        Image(production.backgroundImageName)
            .resizable()
            .frame(width: size.width * 2.7, height: size.height * 1.2)
    }

    private func fetchButton(text: String, fetch: @escaping () async -> Void) -> some View {
        Button {
            Task {
                await fetch()
            }
        } label: {
            Text(text)
                .font(.title3)
                .foregroundStyle(.white)
                .padding()
                .background(Color(production.buttonColorName))
                .clipShape(.rect(cornerRadius: 7))
                .shadow(color: Color(production.shadowColorName), radius: 5)
        }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundImage(geoSize: geo.size)

                VStack {
                    VStack {
                        Spacer(minLength: 60)

                        switch viewModel.fetchStatus {
                        case .idle:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            QuoteView(
                                quote: viewModel.quote,
                                character: viewModel.character,
                                production: production,
                                geo: geo,
                                showCharacterView: $showCharacterView
                            )
                        case let .failure(error):
                            Text(error.localizedDescription)
                        }

                        Spacer()
                    }

                    fetchButton(text: "Get Random Quote") {
                        await viewModel.fetchQuoteData(for: production)
                    }

                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterView) {
            if let character = viewModel.character {
                CharacterView(production: production, character: character)
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    QuoteEpisodeView(production: .breakingBad, viewModel: .preview)
        .preferredColorScheme(.dark)
}
