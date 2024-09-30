//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/23.
//

import Inject
import SwiftUI

struct QuoteView: View {
    @State private var characterImg: Image?
    @State private var showCharacterInfo = false
    let production: Production
    private let viewModel = ViewModel()

    init(production: Production) {
        self.production = production

        Task { [self] in
            await viewModel.fetchData(for: production)
        }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(production.backgroundImageName)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)

                VStack {
                    VStack {
                        Spacer(minLength: 60)

                        switch viewModel.fetchStatus {
                        case .idle:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text(viewModel.quote!.quote)
                                .minimumScaleFactor(0.5)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)

                            ZStack(alignment: .bottom) {
                                AsyncImage(url: viewModel.character?.images.randomElement()) { img in
                                    img
                                        .resizable()
                                        .scaledToFill()
                                        .onAppear {
                                            characterImg = img
                                        }
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)

                                Text(viewModel.character!.name)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                if viewModel.character != nil, characterImg != nil {
                                    showCharacterInfo = true
                                }
                            }
                        case let .failure(error):
                            Text(error.localizedDescription)
                        }

                        Spacer()
                    }

                    Button {
                        characterImg = nil
                        Task {
                            await viewModel.fetchData(for: production)
                        }
                    } label: {
                        Text("Get Random Quotes")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color(production.buttonColorName))
                            .clipShape(.rect(cornerRadius: 7))
                            .shadow(color: Color(production.shadowColorName), radius: 5)
                    }

                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            CharacterView(characterImg: $characterImg, production: production, character: viewModel.character!)
        }
    }
}

#Preview {
    QuoteView(production: .breakingBad)
        .preferredColorScheme(.dark)
}
