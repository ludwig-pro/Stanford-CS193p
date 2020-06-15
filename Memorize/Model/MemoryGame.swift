//
//  MemoryGame.swift
//  Memorize
//
//  Created by ludwig vantours on 20/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  var score: Int = 0
  var theme: Theme
  var chosenCardTimeStamp : Date?
  
  private var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
        scoreSystem(chosenIndex: chosenIndex, potentialMatchIndex: potentialMatchIndex)
        self.cards[chosenIndex].isFaceUp = true
      } else {
        chosenCardTimeStamp = Date()
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
    
      }
    }
  }
  

  
  mutating func scoreSystem(chosenIndex : Int, potentialMatchIndex: Int ) {
    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
      cards[chosenIndex].isMatched = true
      cards[potentialMatchIndex].isMatched = true
      score += 2
//      extraPoints()
    } else {
      if(cards[chosenIndex].seen || cards[potentialMatchIndex].seen) {
        self.score -= 1
      } else {
        cards[chosenIndex].seen = true
        cards[potentialMatchIndex].seen = true
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
    var isFaceUp: Bool = false {
      didSet {
        if isFaceUp {
          startUsingBonusTime()
        } else {
          stopUsingBonusTime()
        }
      }
    }
    var isMatched: Bool = false {
      didSet {
        stopUsingBonusTime()
      }
    }
    var content: CardContent
    var seen: Bool = false
    
    // MARK: - Bonus Time
    
    // can be zero which means "no bonus available" for this card
    var bonusTimeLimit: TimeInterval = 6;
    //how long this card has ever been face up
    private var faceUpTime: TimeInterval {
      if let lastFaceUpDate = self.lastFaceUpDate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }
    // the last time this card was turned face up (and is still face up)
    var lastFaceUpDate: Date?
    // the accumulated time this card has been face up in the past
    // (i.e. not including the current time it's been face up if it is currently so)
    var pastFaceUpTime: TimeInterval = 0
    
    // how much time left before the bonus opportunity runs out
    var bonusTimeRemaining: TimeInterval {
      max(0, bonusTimeLimit - faceUpTime)
    }
    // percentage of the bonus time remaining
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    // whether the card was matched during the bonus time period
    var hasEarnedBonus: Bool {
      isMatched && bonusTimeRemaining > 0
    }
    // whether we are currently face up, unmatched and have not yet used up the bonus window
    var isConsumingBonusTime: Bool {
      isFaceUp && !isMatched && bonusTimeRemaining > 0
    }
    
    // called when the card transitions to face up state
    private mutating func startUsingBonusTime() {
      if isConsumingBonusTime, lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    // called when the card goes back face down (or gets matched)
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      self.lastFaceUpDate = nil
    }
  }
  
  mutating func extraPoints() {
    if let chosenCardTimeStamp = chosenCardTimeStamp {
      let interval = abs(chosenCardTimeStamp.timeIntervalSince(Date()))
      if interval < 5 {
        score += 5
      }
    }
  }
  
 
  
}
