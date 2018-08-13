//
//  PlayerOne.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

struct PlayerOne {
  var name: String
  var symbol: UIImage
  var wins: Int
  
  init(name: String, symbol: UIImage, wins: Int) {
    self.name = "Player 1"
    self.symbol = UIImage(assetIdentifier: .cross)
    self.wins = 0
  }
}
