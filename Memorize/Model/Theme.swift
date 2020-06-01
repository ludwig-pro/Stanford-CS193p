//
//  Theme.swift
//  Memorize
//
//  Created by ludwig vantours on 31/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import Foundation
import SwiftUI

let theme = [halloween, food, animal, sport, kittens, cars]

struct Theme {
  let name: String
  let emojis: [String]
  let numberOfPairsOfCards: Int
  let mainColor: Color
  
  init(name: String, emojis: [String], mainColor: Color) {
    self.name = name
    self.emojis = emojis.shuffled()
    self.numberOfPairsOfCards = Int.random(in: 2..<emojis.count)
    self.mainColor = mainColor
  }
}

let halloween = Theme(name: "halloween", emojis: ["👻", "🎃", "🕷", "🧟‍♀️", "🧛🏾", "🧠", "🦇", "🐍", "💀", "🤡", "⛈", "🧛🏻‍♂️" ], mainColor: .orange)

let food = Theme(name: "foodies", emojis: ["🥨", "🍗", "🍕", "🍟", "🥗", "🌯", "🍉", "🍣 ", "🍦"], mainColor: .red)

let animal = Theme(name: "animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"], mainColor: .blue)

let sport = Theme(name: "sports", emojis: ["🏀", "⚾️", "⚽️", "🎾", "🏈", "🥏", "🏓", "🏸", "🏒", "⛳️", "🥊", "🛹"], mainColor: .purple)
let kittens = Theme(name: "kittens", emojis: ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾"], mainColor: .yellow)

let cars = Theme(name: "cars", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚜", "🛺"], mainColor: .gray)



