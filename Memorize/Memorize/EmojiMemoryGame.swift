//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 20.04.2023.
//

import SwiftUI

// MARK: - View Model
// separates view from model
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["✈️", "🚅", "🛳️", "🚀", "🚞", "🛫", "🚆", "⛵️", "🚐", "🚑", "🚒", "🚙"]
  
    // define how many pairs of cards
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 5) { pairIndex in EmojiMemoryGame.emojis[pairIndex]}
    }
    
    //Type inference and generic function parameter
    @Published private(set) var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card: card)
    }
}

// supplies generic requirement of MemoryGame model to create card content
//func makeCardContent(index: Int) -> String {
//    return "😀"
//}
