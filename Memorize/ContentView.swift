//
//  ContentView.swift
//  Memorize
//
//  Created by KevinMartinez on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .foregroundStyle(Color.orange)
        .padding()
        
    }
}


struct CardView: View {
   @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            var base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                base.foregroundStyle(Color.white)
                base.strokeBorder(style:StrokeStyle(lineWidth: 2))
                Text("👻")
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

