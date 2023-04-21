//
//  MemoryGame.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 20.04.2023.
//

import Foundation

// MARK: - Model
struct MemoryGame<CardContent> where CardContent : Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.cards = Array<Card>()
        // add number of pairs x 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            self.cards.append(Card(id: pairIndex * 2, content: content))
            self.cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
    }
    
    mutating func choose(card: Card) {
        // 1. Check if passed card is in array, is face down and not matched with another card
        if let index = cards.firstIndex(where: { $0.id == card.id}), !cards[index].isFaceUp,
            !cards[index].isMatched {
            // 2. Check if some card by index was really selected before
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // 3. compare two cards: 1) which is selected 2) which was selected earlier
                if cards[index].content == cards[potentialMatchIndex].content {
                    // 4. if their content is same, change variable isMatched to true
                    cards[index].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                // 4.1 make index of previously selected card nil
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // 5. if cards not matched, turn them all down
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                // 5. last picked card stays face up
                indexOfTheOneAndOnlyFaceUpCard = index
            }
            cards[index].isFaceUp.toggle()
        }
    }
    
    // MARK: - Inner struct -> out of context calls can't reach this struct
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // generic definition goes to outer struct
    }
}

