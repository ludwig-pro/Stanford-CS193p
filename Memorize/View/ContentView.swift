//
//  ContentView.swift
//  Memorize
//
//  Created by ludwig vantours on 19/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  

  var game : EmojiMemoryGame
  
  var body: some View {
    VStack {
        HStack {
          ForEach(game.cards) { card in
            CardView(card: card).onTapGesture {
              self.game.choose(card: card)
            }
          }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(game.cards.count > 4 ? Font.title : Font.largeTitle)
    }
  }
}

struct CardView: View {
  var card: MemoryGame<String>.Card
  
  var body: some View {
    ZStack() {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
        RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
        Text(card.content)
      } else {
        RoundedRectangle(cornerRadius: 10.0).fill()
        
      }
    }.aspectRatio(2/3, contentMode: .fit)
  }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(game: EmojiMemoryGame())
    }
}

