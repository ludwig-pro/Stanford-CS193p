//
//  MemoryGame.swift
//  Memorize
//
//  Created by ludwig vantours on 20/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
  var cards: Array<Card>
  var score: Int = 0
  var theme: Theme
  
  var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.only }
    set {
      for index in cards.indices {
          cards[index].isFaceUp = index == newValue
      }
    }
  }
  
  
  mutating func choose(card : Card) {
    print("card choosed : \(card)")
    if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
          score += 2
        } else {
          score -= 1
        }
        self.cards[chosenIndex].isFaceUp = true
      } else {
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
    
      }
    }
  }
  
  init(theme: Theme, cardContentFactory: (Int) -> CardContent ) {
    let numberOfPairsOfCards = theme.numberOfPairsOfCards
    var cards = Array<Card>()
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(id: pairIndex*2, content: content))
      cards.append(Card(id: pairIndex*2+1, content: content))
    }
    self.cards = cards.shuffled()
    self.theme = theme
  }
  
  struct Card : Identifiable {    
    var id: Int
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
  }
  
}
