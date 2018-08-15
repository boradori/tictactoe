//
//  Player.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

struct Player {
  var number: Int
  var name: String
  var symbol: UIImage
  var wins: Int
  
  init(number: Int, name: String, symbol: UIImage, wins: Int) {
    self.number = number
    self.name = name
    self.symbol = symbol
    self.wins = wins
  }
}
