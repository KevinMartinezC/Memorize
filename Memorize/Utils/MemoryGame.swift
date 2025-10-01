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
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            }else {
                return nil
            }
            
        }
        set{
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                }else {
                    cards[index].isFaceUp = false
                }
            }
        }
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
                    // There's ONE card face up, we're choosing the SECOND
                    // Check for match
                    if cards[pontentialMatchIndex].content == cards[chosenIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[pontentialMatchIndex].isMatched = true
                    }
                    // DON'T set indexOfTheOneAndOnlyFaceUpCard here!
                    // This allows both cards to stay visible
                } else {
                    // There are 0 or 2 cards face up, flip them all down and show only this one
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
