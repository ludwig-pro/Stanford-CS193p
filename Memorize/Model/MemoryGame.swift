//
//  MemoryGame.swift
//  Memorize
//
//  Created by ludwig vantours on 20/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

struct MemoryGame<CardContent> {
  var cards: Array<Card>
  
  mutating func choose(card : Card) {
    print("card choosed : \(card)")
    let chosenIndex: Int = index(of: card)
    cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
  }
  
  func index (of card: Card) -> Int {
    
    for index in 0..<cards.count {
      if cards[index].id == card.id {
        return index
      }
    }
    return 0 // TODO : bogus !
    
//    return cards.firstIndex(of: card)!
  }
  
  init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
    var cards = Array<Card>()
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(id: pairIndex*2, content: content))
      cards.append(Card(id: pairIndex*2+1, content: content))
    }
    self.cards = cards.shuffled()
  }
  
  struct Card : Identifiable, Equatable {
    static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
      lhs.id == rhs.id
    }
    
    var id: Int
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
  }
}
