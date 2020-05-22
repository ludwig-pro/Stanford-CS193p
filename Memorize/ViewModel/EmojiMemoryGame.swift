//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ludwig vantours on 20/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
  
  // model
  private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

  static func createMemoryGame() -> MemoryGame<String> {
    let emojis = ["👻", "🎃", "🕷", "🧟‍♀️", "🧛🏾", "🧠", "🦇", "🐍", "💀", "🤡", "⛈", "🧛🏻‍♂️" ].shuffled()
    let numberOfPairsOfCards = Int.random(in: 2..<5)
    return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in emojis[pairIndex] }
  }
  
  // MARK: - Access to the Model
  
  var cards : Array<MemoryGame<String>.Card> {
    return game.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(card: MemoryGame<String>.Card) {
    game.choose(card: card)
  }
  
}

struct EmojiMemoryGame_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}
