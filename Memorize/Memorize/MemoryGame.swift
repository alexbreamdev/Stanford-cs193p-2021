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
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.cards = []
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
                cards[index].isFaceUp = true
            } else {
                // 5. last picked card stays face up
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // MARK: - Inner struct -> out of context calls can't reach this struct
    struct Card: Identifiable {
        let id: Int
        var isFaceUp = false
        var isMatched = false
        let content: CardContent // generic definition goes to outer struct
    }
}

extension Array {
    var oneAndOnly: Element? {
        return self.count == 1 ? self.first : nil
    }
}

