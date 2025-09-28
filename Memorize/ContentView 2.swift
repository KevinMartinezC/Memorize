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
            title
            ScrollView{
                cards
            }
            themeButtons
        }
        .padding()
    }

    var cards: some View {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
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
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .bold()
    }
    
    var themeButtons: some View {
           HStack {
               ForEach(Theme.allCases, id: \.self) { theme in
                   themeButton(for: theme)
               }
           }
       }
       
       func themeButton(for theme: Theme) -> some View {
           VStack {
               Image(systemName: theme.sfSymbol)
                   .font(.system(size: 30))
               Text(theme.name)
                   .font(.caption)
           }
           .foregroundStyle(viewModel.currentSelectedTheme == theme ? .blue : .gray)
           .onTapGesture {
               viewModel.changeTheme(to: theme)
           }
       }
}
