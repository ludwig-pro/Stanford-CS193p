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
            withAnimation(.linear(duration : 0.75)) {
              self.game.choose(card: card)
            }
          }.padding(5)
        }
        .padding()
        Text("Score : \(game.score)").bold().font(.system(size: 30))
      }.foregroundColor(game.mainColor)
      .navigationBarItems(
        trailing:Button(action: {
          withAnimation(.easeInOut) {
            self.game.newGame()
          }
        }) {
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
    let gradient = Gradient(colors: [mainColor, (secondColor != nil) ? secondColor! : mainColor])
    return GeometryReader { geometry in
      self.body(for: geometry.size, gradient: gradient)
    }
  }
  
  @State private var animatedBonusRemaining: Double = 0
  
  private func startBonusTimeAnimation() {
    animatedBonusRemaining = card.bonusRemaining
    withAnimation(.linear(duration : card.bonusTimeRemaining) ) {
      animatedBonusRemaining = 0
    }
  }
  
  @ViewBuilder
  private func body(for size: CGSize, gradient: Gradient) -> some View {
    if card.isFaceUp || !card.isMatched {
      ZStack() {
        Group {
        if(card.isConsumingBonusTime) {
          Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining*360 - 90), clockwise: true)
        
            .onAppear {
                self.startBonusTimeAnimation()
            }
        } else {
          Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining*360 - 90), clockwise: true)
        }
        }.padding(4)
          .opacity(0.4).transition(.identity)
        Text(card.content)
          .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
          .animation( card.isMatched ? Animation.linear(duration: 1)
          .repeatForever(autoreverses: false) : .default)
        
      }.modifier(Cardify(isFaceUp: card.isFaceUp, gradient: gradient)).font(Font.system(size: fontSize(for: size)) ).transition(.scale)
      
    } }
  
  private func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * fontScaleFactor
  }
}


private let fontScaleFactor: CGFloat = 0.70










struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    game.choose(card: game.cards[0])
    return EmojiMemoryGameView(game:game)
  }
}

