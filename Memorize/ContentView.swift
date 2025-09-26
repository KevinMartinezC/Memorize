//
//  ContentView.swift
//  Memorize
//
//  Created by KevinMartinez on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "🎃", "🕷️", "👺","😳", "🧟‍♀️", "🧟‍♂️", "🎭", "🎨", "👩‍🎨", "👽", "🤯"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            cards
            cardCountAdjusters
        }
        .padding()
        
    }
    
    var cardCountAdjusters: some View {
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(Font.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button( action: {
                cardCount += offset
            
        },label :{
            Image(systemName:symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    
    }
    var cards: some View {
        HStack{
            ForEach(0..<cardCount, id: \.self){index in
                CardView(content: emojis[index])
            }
        }
        .foregroundStyle(.orange)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
}


struct CardView: View {
    let content: String
   @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                base.foregroundStyle(Color.white)
                base.strokeBorder(style:StrokeStyle(lineWidth: 2))
                Text(content)
            }else{
                base
            }
            
        }.onTapGesture {
            isFaceUp.toggle()
        }
        
    }
}

#Preview {
    ContentView()
}

