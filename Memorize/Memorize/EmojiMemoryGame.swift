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
    static let emojis: Array<String> = ["✈️", "🚅", "🛳️", "🚀", "🚞", "🛫", "🚆", "⛵️", "🚐", "🚑", "🚒", "🚙"]
  
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 5) { pairIndex in EmojiMemoryGame.emojis[pairIndex]}
    }
    
    //Type inference and generic function parameter
    private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}

// supplies generic requirement of MemoryGame model to create card content
//func makeCardContent(index: Int) -> String {
//    return "😀"
//}
