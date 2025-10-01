//
//  Theme.swift
//  Memorize
//
//  Created by KevinMartinez on 9/28/25.
//


import SwiftUI
import Combine

enum Theme: CaseIterable {
    case vehicles, animals, food, sports, nature, weather
    
    var name: String {
        switch self {
        case .vehicles: return "Vehicles"
        case .animals: return "Animals"
        case .food: return "Food"
        case .sports: return "Sports"
        case .weather: return "Weather"
        case .nature: return "Nature"
        }
    }
    
    var color: Color {
        switch self {
        case .vehicles: return .blue
        case .animals: return .green
        case .food: return .red
        case .sports: return .yellow
        case .weather: return .purple
        case .nature: return .orange
        }
    }
    
    var emojis: [String] {
        switch self {
        case .vehicles:
            return ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚"]
        case .animals:
            return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"]
        case .food:
            return ["🍎", "🍌", "🍇", "🍓", "🍒", "🥝", "🍑", "🥭", "🍉", "🍊"]
        case .sports:
            return ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸"]
        case .nature:
            return ["🌸", "🌺", "🌻", "🌷", "🌹", "🌼", "🌲", "🌳", "🌴", "🌵"]
        case .weather:
            return ["☀️", "🌙", "⭐️", "⛅️", "⛈️", "🌤️", "🌧️", "❄️", "🌈", "⚡️"]
        }
    }
    
    var numberOfPairs: Int {
        switch self {
        case .vehicles: return 6
        case .animals: return 8
        case .food: return 5
        case .sports: return 7
        case .nature: return 6
        case .weather: return 8
        }
    }
    
    static func random() -> Theme {
        Theme.allCases.randomElement()!
    }
}
