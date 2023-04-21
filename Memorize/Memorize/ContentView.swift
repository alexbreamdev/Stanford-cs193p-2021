//
//  ContentView.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 16.04.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        // MARK: - ViewBuilder combines list of views in one view and returns it in tuple view
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], spacing: 8) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            withAnimation {
                                viewModel.choose(card)
                            }
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            ContentView(viewModel: game)
                .previewDevice("iPhone 14")
            ContentView(viewModel: game)
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    private var degree: Double {
        card.isFaceUp ? 0 : 180
    }
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.primary)
                    .colorInvert()
                // stroke vs strokeBorder
                // stroke loses half of width while in another container
                shape.strokeBorder(lineWidth: 3)
                
                Text(card.content)
                    .font(.largeTitle)
                
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
            
            
        }
        .rotation3DEffect(.degrees(degree), axis: (x: 0, y: 1, z: 0), anchor: .center)
        
    }
}
