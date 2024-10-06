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
    let viewModel: ViewModel
    @ObserveInjection var injection
    @State private var showCharacterView = false
    @Environment(\.geometrySize) private var size

    init(production: Production, viewModel: ViewModel = ViewModel()) {
        self.production = production
        self.viewModel = viewModel

        Task {
            await viewModel.fetchData(for: production)
        }
    }

    // MARK: - Views

    private var backgroundImage: some View {
        Image(production.backgroundImageName)
            .resizable()
            .frame(width: size.width * 2.7, height: size.height * 1.2)
    }

    @ViewBuilder private var quoteContent: some View {
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

    @ViewBuilder private var characterContent: some View {
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
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .onTapGesture {
                showCharacterView = true
            }
            .accessibilityAddTraits(.isButton)
        } else {
            EmptyView()
        }
    }

    private var fetchButton: some View {
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
        ZStack {
            backgroundImage

            VStack {
                VStack {
                    Spacer(minLength: 80)

                    switch viewModel.fetchStatus {
                    case .idle:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                    case .success:
                        quoteContent
                        characterContent
                    case let .failure(error):
                        Text(error.localizedDescription)
                    }

                    Spacer()
                }

                fetchButton

                Spacer(minLength: 85)
            }
            .frame(width: size.width, height: size.height)
        }
        .frame(width: size.width, height: size.height)
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
    GeometryReader { geo in
        QuoteView(production: .breakingBad, viewModel: .preview)
            .preferredColorScheme(.dark)
            .environment(\.geometrySize, geo.size)
    }
    .ignoresSafeArea()
}
