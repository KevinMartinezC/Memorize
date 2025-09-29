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
    
    private static let vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚"]
    private static let animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
    private static let foodEmojis = ["🍎", "🍌", "🍇", "🍓", "🍒", "🥝", "🍑", "🥭"]
    
    @Published private var model: MemoryGame<String>
    @Published var currentSelectedTheme: Theme
    
    init() {
        currentSelectedTheme = .vehicles
        model = MemoryGameViewModel.createMemoryGame(theme: .vehicles)
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = getEmojisForTheme(theme)
        let numberOfPairs = getNumberOfPairsForTheme(theme)
        
        return MemoryGame(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁇"
            }
        }
    }
    
    private static func getEmojisForTheme(_ theme: Theme) -> [String] {
        switch theme {
        case .vehicles:
            return vehicleEmojis.shuffled()
        case .animals:
            return animalEmojis.shuffled()
        case .food:
            return foodEmojis.shuffled()
        }
    }
    
    private static func getNumberOfPairsForTheme(_ theme: Theme) -> Int {
        switch theme {
        case .vehicles:
            return  Int.random(in: 4...6)
        case .animals:
            return Int.random(in: 5...8)
        case .food:
            return Int.random(in: 3...6)
        }
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var adaptiveCardWidth: CGFloat {
        let cardCount = cards.count
        
        if cardCount <= 8 {
            return 120
        } else if cardCount <= 16 {
            return 95
        } else if cardCount <= 24 {
            return 75
        } else {
            return 60
        }
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
