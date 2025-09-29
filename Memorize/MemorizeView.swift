//
//  ContentView 2.swift
//  Memorize
//
//  Created by KevinMartinez on 9/28/25.
//

import SwiftUI

struct MemorizeView: View {
    @StateObject var viewModel: MemoryGameViewModel = .init()
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
            ScrollView{
                cards
            }
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: viewModel.cards.count.adaptiveCardWidth), spacing: 0)],
            spacing: 0
        ) {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(viewModel.currentSelectedTheme.color)
    }
    
    var themeButtons: some View {
        HStack {
            ForEach(Theme.allCases, id: \.self) { theme in
                ThemeButton(
                    theme: theme,
                    isSelected: viewModel.currentSelectedTheme == theme
                ) {
                    viewModel.changeTheme(to: theme)
                }
            }
        }
    }
}
