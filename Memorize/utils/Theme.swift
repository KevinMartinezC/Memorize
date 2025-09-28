//
//  Theme.swift
//  Memorize
//
//  Created by KevinMartinez on 9/28/25.
//


import SwiftUI
import Combine

enum Theme: CaseIterable {
        case vehicles, animals, food
        
        var name: String {
            switch self {
            case .vehicles: return "Vehicles"
            case .animals: return "Animals"
            case .food: return "Food"
            }
        }
        
        var sfSymbol: String {
            switch self {
            case .vehicles: return "car.fill"
            case .animals: return "pawprint.fill"
            case .food: return "fork.knife"
            }
        }
    }