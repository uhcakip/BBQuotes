//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/26.
//

import Inject
import SwiftUI

struct CharacterView: View {
    // MARK: - Variables

    let production: Production
    let character: Character
    @ObserveInjection var injection
    @Environment(\.geometrySize) private var size

    // MARK: - Views

    private var backgroundImage: some View {
        Image(production.backgroundImageName)
            .resizable()
            .scaledToFit()
    }

    @ViewBuilder private var characterGallery: some View {
        TabView {
            ForEach(character.images, id: \.self) { imageURL in
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(.page)
        .frame(width: size.width / 1.2, height: size.height / 1.7)
        .clipShape(.rect(cornerRadius: 25))
        .padding(.top, 60)
    }

    @ViewBuilder private var characterInfo: some View {
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
    }

    @ViewBuilder private var characterStatus: some View {
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

    var body: some View {
        ZStack(alignment: .top) {
            backgroundImage

            ScrollView {
                characterGallery

                VStack(alignment: .leading) {
                    characterInfo
                    characterStatus
                }
                .frame(width: size.width / 1.25, alignment: .leading)
                .padding(.bottom, 50)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    struct PreviewCharacterView: View {
        @State private var characterImage: Image?

        var body: some View {
            GeometryReader { geo in
                CharacterView(production: .breakingBad, character: .mock)
                    .preferredColorScheme(.dark)
                    .environment(\.geometrySize, geo.size)
                    .onAppear {
                        if let url = Character.mock.images.first,
                           let imageData = try? Data(contentsOf: url),
                           let uiImage = UIImage(data: imageData) {
                            characterImage = Image(uiImage: uiImage)
                        }
                    }
            }
            .ignoresSafeArea()
        }
    }

    return PreviewCharacterView()
}
