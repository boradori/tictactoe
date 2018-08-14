//
//  Game.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import Foundation

class Game {
  var name: String
  var result: String
  var board: Board
  
  init(name: String, result: String, board: Board) {
    self.name = name
    self.result = result
    self.board = board
  }
}
