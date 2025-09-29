//
//  MemoryGameViewModel.swift
//  Memorize
//
//  Created by KevinMartinez on 9/28/25.
//
import SwiftUI
import Combine

class MemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    @Published var currentSelectedTheme: Theme
    
    init() {
        currentSelectedTheme = .vehicles
        model = MemoryGameViewModel.createMemoryGame(theme: .vehicles)
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairs = Int.random(in: theme.pairRange)
        
        return MemoryGame(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁇"
            }
        }
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func changeTheme(to theme: Theme) {
        currentSelectedTheme = theme
        model = MemoryGameViewModel.createMemoryGame(theme: theme)
    }
}
