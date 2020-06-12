//
//  Cardify.swift
//  Memorize
//
//  Created by ludwig vantours on 12/06/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
  var isFaceUp: Bool
  var gradient: Gradient
  func body(content: Content) -> some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
        content
      } else {
        RoundedRectangle(cornerRadius: cornerRadius).fill( LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .bottom))
      }
    }
  }
}

// MARK: - Drawing Constants
private let cornerRadius : CGFloat = 10
private let edgeLineWidth: CGFloat = 3


extension View {
  func cardify(isFaceUp: Bool, gradient: Gradient) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp, gradient: gradient))
  }
}

