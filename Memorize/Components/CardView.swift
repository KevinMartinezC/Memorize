//
//  CardView.swift
//  Memorize
//
//  Created by KevinMartinez on 9/28/25.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1)
    }
}

#Preview {
    HStack {
        CardView(card: MemoryGame<String>.Card(
            isFaceUp: true,
            content: "🚗",
            id: "1a"
        ))
        
        CardView(card: MemoryGame<String>.Card(
            isFaceUp: false,
            content: "🚗",
            id: "1b"
        ))
    }
    .padding()
}
