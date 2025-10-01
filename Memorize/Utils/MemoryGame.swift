//
//  MemoryGame.swift
//  Memorize
//
//  Created by KevinMartinez on 9/28/25.
//

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter{index in cards[index].isFaceUp}.only}
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }}
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
                if let pontentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    // Second card chosen - check for match
                    if cards[pontentialMatchIndex].content == cards[chosenIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[pontentialMatchIndex].isMatched = true
                        score += 2  // Add points for match
                    } else {
                        // No match
                        // Penalty if either card has been seen before
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[pontentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                    // Mark both cards as seen
                    cards[chosenIndex].hasBeenSeen = true
                    cards[pontentialMatchIndex].hasBeenSeen = true
                } else {
                    // First card or third card
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false 
        let content: CardContent
        let id: String
    }
}
