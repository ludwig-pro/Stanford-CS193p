//
//  Array+only.swift
//  Memorize
//
//  Created by ludwig vantours on 28/05/2020.
//  Copyright © 2020 ludwig vantours. All rights reserved.
//

import Foundation

extension Array {
  var only: Element? {
    count == 1 ? first : nil
  }
}
