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
    
    func newGame() {
        let theme = Theme.random()
        currentSelectedTheme = theme
        game = MemoryGameViewModel.createMemoryGame(theme: theme)
    }
    
    func changeTheme(to theme: Theme) {
        currentSelectedTheme = theme
        game = MemoryGameViewModel.createMemoryGame(theme: theme)
    }
}

extension MemoryGameViewModel {
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairs = theme.numberOfPairs
        
        return MemoryGame(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁇"
            }
        }
    }
    
    static func make() -> MemoryGameViewModel {
        let theme = Theme.random()
        return .init(
            theme: theme,
            game: MemoryGameViewModel.createMemoryGame(theme: theme)
        )
    }
}
