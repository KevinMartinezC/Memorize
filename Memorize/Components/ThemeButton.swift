//
//  ThemeButton.swift
//  Memorize
//
//  Created by KevinMartinez on 9/29/25.
//
import SwiftUI

struct ThemeButton: View {
    let theme: Theme
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: theme.sfSymbol)
                .font(.system(size: 30))
            
            Text(theme.name)
                .font(.caption)
        }
        .foregroundStyle(isSelected ? .blue : .gray)
        .onTapGesture(perform: onTap)
    }
}
