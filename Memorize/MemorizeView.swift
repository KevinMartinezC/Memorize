//
//  ContentView 2.swift
//  Memorize
//
//  Created by KevinMartinez on 9/28/25.
//

import SwiftUI

struct MemorizeView: View {
    @StateObject var viewModel: MemoryGameViewModel = .make()
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
            
            Text(viewModel.currentSelectedTheme.name)
                .font(.title2)
                .foregroundStyle(viewModel.currentSelectedTheme.color)
            
            Text("Score: \(viewModel.game.score)")
                .font(.title3)
                .padding(.bottom,8)
            
            ScrollView{
                cards
                    .animation(.default, value: viewModel.game.cards)
            }
            
            Button(action: {
                viewModel.newGame()
            }) {
                Text("New Game")
                    .font(.headline)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(viewModel.currentSelectedTheme.color)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: viewModel.game.cards.count.adaptiveCardWidth), spacing: 0)],
            spacing: 0
        ) {
            ForEach(viewModel.game.cards) { card in
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
}
