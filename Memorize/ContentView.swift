//
//  ContentView.swift
//  Memorize
//
//  Created by ludwig vantours on 19/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      ForEach(0..<4) { item in
        HStack {
          ForEach(0..<4) { item in
            CardView(isFaceUp: true)
          }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
      }
    }
  }
}

struct CardView: View {
  var isFaceUp: Bool
  
  var body: some View {
    ZStack() {
      if isFaceUp {
      RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
      RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
      Text("👻")
      } else {
        RoundedRectangle(cornerRadius: 10.0).fill()

      }
    }

  }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

