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
            return vehicleEmojis
        case .animals:
            return animalEmojis
        case .food:
            return foodEmojis
        }
    }
    
    private static func getNumberOfPairsForTheme(_ theme: Theme) -> Int {
        switch theme {
        case .vehicles:
            return 6
        case .animals:
            return 5
        case .food:
            return 4
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
