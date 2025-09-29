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
    
    @Published var game: MemoryGame<String>
    @Published var currentSelectedTheme: Theme
    
    init(
        theme: Theme,
        game: MemoryGame<String>
    ) {
        currentSelectedTheme = theme
        self.game = game
    }
    
    // MARK: - Actions
    
    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func changeTheme(to theme: Theme) {
        currentSelectedTheme = theme
        game = MemoryGameViewModel.createMemoryGame(theme: theme)
    }
}

extension MemoryGameViewModel {
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
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
    
    static func make() -> MemoryGameViewModel {
        .init(
            theme: .vehicles,
            game:  MemoryGameViewModel.createMemoryGame(theme: .vehicles)
        )
    }
}
