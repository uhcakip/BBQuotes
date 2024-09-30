//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/26.
//

import Inject
import SwiftUI

struct CharacterView: View {
    @Binding var characterImg: Image?
    let production: Production
    let character: Character

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(production.backgroundImageName)
                    .resizable()
                    .scaledToFit()

                ScrollView {
                    if let characterImg {
                        characterImg
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                            .clipShape(.rect(cornerRadius: 25))
                            .padding(.top, 60)
                    }

                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)

                        Text("Portrayed by \(character.portrayedBy)")
                            .font(.subheadline)

                        Divider()

                        Text("\(character.name) Character Info")
                            .font(.title2)

                        Text("Born: \(character.birthday)")

                        Divider()

                        Text("Occupations:")

                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("· \(occupation)")
                                .font(.subheadline)
                        }

                        Divider()

                        Text("Nicknames:")

                        if !character.aliases.isEmpty {
                            ForEach(character.aliases, id: \.self) { alias in
                                Text("· \(alias)")
                                    .font(.subheadline)
                            }
                        } else {
                            Text("None")
                                .font(.subheadline)
                        }

                        Divider()

                        DisclosureGroup("Status (spoiler alert)") {
                            VStack(alignment: .leading) {
                                Text(character.status)
                                    .font(.title2)

                                if let death = character.death {
                                    AsyncImage(url: death.image) { img in
                                        img
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }

                                    Text("How: \(death.details)")
                                        .padding(.bottom, 7)

                                    Text("Last words: \"\(death.lastWords)\"")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .tint(.primary)
                    }
                    .frame(width: geo.size.width / 1.25, alignment: .leading)
                    .padding(.bottom, 50)
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    struct PreviewCharacterView: View {
        private let viewModel = ViewModel()
        @State private var characterImg: Image?

        @MainActor
        private func loadImage(from urlString: String) async {
            guard let url = URL(string: urlString) else {
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    characterImg = Image(uiImage: uiImage)
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }

        var body: some View {
            VStack {
                if characterImg != nil {
                    CharacterView(characterImg: $characterImg, production: .breakingBad, character: viewModel.character!)
                        .preferredColorScheme(.dark)
                } else {
                    ProgressView()
                }
            }
            .task {
                await viewModel.fetchData(for: .breakingBad)
                if let imageURL = viewModel.character?.images.randomElement() {
                    await loadImage(from: imageURL.absoluteString)
                }
            }
        }
    }

    return PreviewCharacterView()
}
