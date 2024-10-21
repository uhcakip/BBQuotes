import SwiftUI

struct QuoteView: View {
    let quote: Quote?
    let character: Character?
    let production: Production
    let geo: GeometryProxy
    @Binding var showCharacterView: Bool

    var body: some View {
        VStack {
            if let quote {
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

            if let character {
                ZStack(alignment: .bottom) {
                    AsyncImage(url: character.images.first) { image in
                        image
                            .resizable()
                            .scaledToFill()
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
                .clipShape(.rect(cornerRadius: 50))
                .onTapGesture {
                    showCharacterView = true
                }
                .accessibilityAddTraits(.isButton)
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    GeometryReader { geo in
        QuoteView(
            quote: Quote.mock,
            character: Character.mock,
            production: .breakingBad,
            geo: geo,
            showCharacterView: .constant(false)
        )
    }
    .preferredColorScheme(.dark)
}
