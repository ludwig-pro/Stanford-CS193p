//
//  Array+identifiable.swift
//  Memorize
//
//  Created by ludwig vantours on 28/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
  func firstIndex(matching: Element) -> Int? {
    for index in 0..<self.count {
      if self[index].id == matching.id {
        return index
      }
    }
    return nil
  }
}
