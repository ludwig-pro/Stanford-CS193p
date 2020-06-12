//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ludwig vantours on 20/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
      
  // model
  @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

  private static func createMemoryGame() -> MemoryGame<String> {
    let emojiTheme = theme.randomElement()!
    return MemoryGame<String>(theme : emojiTheme ) { pairIndex in emojiTheme.emojis[pairIndex] }
  }

  
  
  // MARK: - Access to the Model
  
  var cards : Array<MemoryGame<String>.Card> {
    return game.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(card: MemoryGame<String>.Card) {
    game.choose(card: card)
  }
  
  func newGame() {
    game = EmojiMemoryGame.createMemoryGame()
  }
  
  var themeName : String {
    return game.theme.name
  }
  
  var mainColor : Color {
    return game.theme.mainColor
  }
  
  var secondColor : Color? {
    return game.theme.secondColor
  }
  
  var score : Int {
    return game.score
  }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}
