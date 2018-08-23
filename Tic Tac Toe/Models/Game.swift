//
//  Game.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import Foundation

struct Game {
  private(set) var count: Int
  private(set) var name: String?
  private(set) var result: String?
  private(set) var board: Board?
  private(set) var players: [Player]?
  
  init(count: Int, name: String?, result: String?, board: Board?, players: [Player]?) {
    self.count = count
    self.name = name
    self.result = result
    self.board = board
    self.players = players
  }
  
  mutating func startNewGame() {
    count += 1
    name = "Game \(count)"
    result = nil
    board = nil
    players = nil
  }
  
  mutating func changeResult(_ newResult: String) {
    result = newResult
  }
  
  mutating func addBoard(_ newBoard: Board) {
    board = newBoard
  }
  
  mutating func addPlayers(_ player: Player) {
    if players == nil {
      players = [player]
    } else {
      players!.append(player)
    }
  }
  
  mutating func rotatePlayers() {
    if players != nil {
      players!.append(players!.removeFirst())
    }
  }
}
