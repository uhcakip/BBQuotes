//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/26.
//

import Inject
import SwiftUI

struct CharacterView: View {
    @Binding var characterImage: Image?
    let production: Production
    let character: Character

    private var backgroundImage: some View {
        Image(production.backgroundImageName)
            .resizable()
            .scaledToFit()
    }

    @ViewBuilder
    private var characterInfo: some View {
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

    @ViewBuilder
    private var characterStatus: some View {
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
        GeometryReader { geo in
            ZStack(alignment: .top) {
                backgroundImage

                ScrollView {
                    if let characterImage {
                        characterImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                            .clipShape(.rect(cornerRadius: 25))
                            .padding(.top, 60)
                    }

                    VStack(alignment: .leading) {
                        characterInfo
                        characterStatus
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
        @State private var characterImage: Image?

        var body: some View {
            CharacterView(characterImage: $characterImage, production: .breakingBad, character: .mock)
                .preferredColorScheme(.dark)
                .onAppear {
                    if let url = Character.mock.images.first,
                       let imageData = try? Data(contentsOf: url),
                       let uiImage = UIImage(data: imageData) {
                        characterImage = Image(uiImage: uiImage)
                    }
                }
        }
    }

    return PreviewCharacterView()
}
