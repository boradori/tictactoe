//
//  Board.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

struct Board {
  var grids: [[UIImage]]
  
  init(grid: [[UIImage]]) {
    self.grids = [[UIImage(), UIImage(), UIImage()],
                  [UIImage(), UIImage(), UIImage()],
                  [UIImage(), UIImage(), UIImage()]]
  }
}
