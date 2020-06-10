//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by ludwig vantours on 19/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  
  @ObservedObject var game : EmojiMemoryGame
  
  var body: some View {
    NavigationView {
      VStack {
        HStack{
          Text("\(game.themeName)").bold().font(.system(size: 30))
          Spacer()
          }.padding()
        Grid(game.cards) {
          card in
          CardView(card: card, mainColor: self.game.mainColor, secondColor: self.game.secondColor).onTapGesture {
            self.game.choose(card: card)
          }.padding(5)
        }
        .padding()
        Text("Score : \(game.score)").bold().font(.system(size: 30))
      }.foregroundColor(game.mainColor)
      .navigationBarItems(
        trailing:Button(action: {self.game.newGame()}) {
          Text("New game")
        }
      ).navigationBarTitle("", displayMode: .inline)
    }.foregroundColor(game.mainColor)
  }
  
}

struct CardView: View {
  var card: MemoryGame<String>.Card
  var mainColor: Color
  var secondColor: Color?
  
  var body: some View {
    GeometryReader { geometry in
      self.body(for: geometry.size)
    }
  }
  
  func body(for size: CGSize) -> some View {
    let gradient = Gradient(colors: [mainColor, (secondColor != nil) ? secondColor! : mainColor])
    
    return ZStack() {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
        Text(card.content)
      } else {
        if !card.isMatched {
          RoundedRectangle(cornerRadius: cornerRadius).fill( LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .bottom))
        }
      }
    }.font(Font.system(size: fontSize(for: size)) )
      
  }
  
  // MARK: - Drawing Constants
  
  let cornerRadius : CGFloat = 10
  let edgeLineWidth: CGFloat = 3
  let fontScaleFactor: CGFloat = 0.75
  
  func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * fontScaleFactor
  }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      EmojiMemoryGameView(game: EmojiMemoryGame())
    }
}

