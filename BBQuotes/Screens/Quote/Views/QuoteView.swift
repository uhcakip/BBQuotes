//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/23.
//

import Inject
import SwiftUI

struct QuoteView: View {
    // MARK: - Variables

    let production: Production
    let viewModel: QuoteViewModel
    @ObserveInjection var injection
    @State private var showCharacterView = false

    init(production: Production, viewModel: QuoteViewModel = QuoteViewModel()) {
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

    private var fetchButton: some View {
        Button {
            Task {
                await viewModel.fetchQuoteData(for: production)
            }
        } label: {
            Text("Get Random Quote")
                .font(.title3)
                .foregroundStyle(.white)
                .padding()
                .background(Color(production.buttonColorName))
                .clipShape(.rect(cornerRadius: 7))
                .shadow(color: Color(production.shadowColorName), radius: 5)
        }
    }

    @ViewBuilder private var quoteContent: some View {
        if let quote = viewModel.quote {
            Text(quote.quote)
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.rect(cornerRadius: 25))
                .padding(.horizontal)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder private func characterContent(geoSize size: CGSize) -> some View {
        if let character = viewModel.character {
            ZStack(alignment: .bottom) {
                AsyncImage(url: character.images.first) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: size.width / 1.1, height: size.height / 1.8)

                Text(character.name)
                    .foregroundStyle(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
            }
            .frame(width: size.width / 1.1, height: size.height / 1.8)
            .clipShape(.rect(cornerRadius: 50))
            .onTapGesture {
                showCharacterView = true
            }
            .accessibilityAddTraits(.isButton)
        } else {
            EmptyView()
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
                            quoteContent
                            characterContent(geoSize: geo.size)
                        case let .failure(error):
                            Text(error.localizedDescription)
                        }

                        Spacer()
                    }

                    fetchButton
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
    QuoteView(production: .breakingBad, viewModel: .preview)
        .preferredColorScheme(.dark)
}
