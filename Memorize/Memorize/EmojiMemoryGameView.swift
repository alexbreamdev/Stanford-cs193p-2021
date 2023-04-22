//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 16.04.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                ForEach(game.cards) { card in
                    CardView(card)
                        .aspectRatio(2 / 3, contentMode: .fit)
                        .onTapGesture {
                            withAnimation {
                                game.choose(card)
                            }
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
                .previewDevice("iPhone 14")
            EmojiMemoryGameView(game: game)
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}

struct CardView: View {
    private let card: EmojiMemoryGame.Card

    private var degree: Double {
        card.isFaceUp ? 0 : 180
    }
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
                if card.isFaceUp {
                    shape
                        .fill()
                        .foregroundColor(.primary)
                        .colorInvert()
                    // stroke vs strokeBorder
                    // stroke loses half of width while in another container
                    shape.strokeBorder(lineWidth: Constants.lineWidth)
                    
                    Text(card.content)
                        .font(font(in: geometry.size))
                    
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
            .rotation3DEffect(.degrees(degree), axis: (x: 0, y: 1, z: 0), anchor: .center)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * Constants.fontScale)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}
