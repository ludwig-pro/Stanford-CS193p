//
//  Cardify.swift
//  Memorize
//
//  Created by ludwig vantours on 12/06/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
  var rotation: Double
  var gradient: Gradient
  
  init(isFaceUp: Bool, gradient: Gradient) {
    rotation = isFaceUp ? 0 : 180
    self.gradient = gradient
  }
  
  var isFaceUp: Bool {
    rotation < 90
  }
  
  var animatableData: Double {
    get { return rotation }
    set { rotation = newValue }
  }
  
  func body(content: Content) -> some View {
    ZStack {
        Group {
          RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
          RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
          content
        }
        .opacity(isFaceUp ? 1 : 0)
        RoundedRectangle(cornerRadius: cornerRadius).fill( LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .bottom)).opacity(isFaceUp ? 0: 1)
      }.rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
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

