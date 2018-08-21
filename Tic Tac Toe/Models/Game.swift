//
//  Game.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import Foundation

struct Game {
  var name: String
  var result: String?
  var board: Board?
  var players: [Player]?
  
  init(name: String, result: String?, board: Board?, players: [Player]?) {
    self.name = name
    self.result = result
    self.board = board
    self.players = players
  }
}
