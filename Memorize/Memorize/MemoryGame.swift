//
//  MemoryGame.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 20.04.2023.
//

import Foundation

// MARK: - Model
struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.cards = Array<Card>()
        // add number of pairs x 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            self.cards.append(Card(content: content))
            self.cards.append(Card(content: content))
        }
        
    }
    func choose(card: Card) {
        
    }
    
    // MARK: - Inner struct -> out of context calls can't reach this struct
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // generic definition goes to outer struct
    }
}

