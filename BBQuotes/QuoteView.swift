//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/23.
//

import Inject
import SwiftUI

struct QuoteView: View {
    @State private var characterInfoImage: Image?
    @State private var showCharacterInfo = false
    let production: Production
    private let viewModel: ViewModel

    init(production: Production, viewModel: ViewModel = ViewModel()) {
        self.production = production
        self.viewModel = viewModel

        Task {
            await viewModel.fetchData(for: production)
        }
    }

    private func backgroundImage(in geo: GeometryProxy) -> some View {
        Image(production.backgroundImageName)
            .resizable()
            .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
    }

    @ViewBuilder
    private var quoteContent: some View {
        if let quote = viewModel.quote {
            Text(quote.quote)
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.horizontal)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func characterImage(in geo: GeometryProxy) -> some View {
        if let character = viewModel.character {
            ZStack(alignment: .bottom) {
                AsyncImage(url: character.images.randomElement()) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .onAppear {
                            characterInfoImage = image
                        }
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)

                Text(character.name)
                    .foregroundStyle(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
            }
            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .onTapGesture {
                showCharacterInfo = true
            }
        } else {
            EmptyView()
        }
    }

    private var quoteButton: some View {
        Button {
            Task {
                await viewModel.fetchData(for: production)
            }
        } label: {
            Text("Get Random Quote")
                .font(.title3)
                .foregroundStyle(.white)
                .padding()
                .background(Color(production.buttonColorName))
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .shadow(color: Color(production.shadowColorName), radius: 5)
        }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundImage(in: geo)

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
                            characterImage(in: geo)
                        case let .failure(error):
                            Text(error.localizedDescription)
                        }

                        Spacer()
                    }

                    quoteButton

                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            if let character = viewModel.character {
                CharacterView(characterImage: $characterInfoImage, production: production, character: character)
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
