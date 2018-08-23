//
//  Board.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import Foundation

struct Board {
  private(set) var grids: [[Int]]
  private(set) var moveIndex: Int
  
  mutating func createGrids(_ numberOfRowsAndCols: Int) {
    grids = Array(repeating: Array(repeating: 0, count: numberOfRowsAndCols), count: numberOfRowsAndCols)
  }
  
  mutating func resetMoveIndex() {
    moveIndex = 0
  }
  
  mutating func incrementMoveIndex() {
    moveIndex += 1
  }
  
  mutating func placePlayerNumber(row: Int, col: Int, playerNumber: Int) {
    grids[row][col] = playerNumber
  }
  
  func checkRow(row: Int, col: Int, playerNumber: Int) -> Bool {
    let desiredRow = Array(repeating: playerNumber, count: grids.count)
    
    if grids[row] == desiredRow {
      return true
    } else {
      if grids.indices.contains(col + 1) && grids[row][col] == grids[row][col + 1] {
        return checkRow(row: row, col: col + 1, playerNumber: playerNumber)
      }
    }
    
    return false
  }
  
  func checkCol(row: Int, col: Int, playerNumber: Int) -> Bool {
    let desiredCol = Array(repeating: playerNumber, count: grids[0].count)
    
    if grids.map({$0[col]}) == desiredCol {
      return true
    } else {
      if grids.indices.contains(row + 1) && grids[row][col] == grids[row + 1][col] {
        return checkCol(row: row + 1, col: col, playerNumber: playerNumber)
      }
    }
    
    return false
  }
  
  func checkDiag(playerNumber: Int) -> Bool {
    let desiredDiag = Array(repeating: playerNumber, count: grids.count)
    
    var leftToRight = [Int]()
    var rightToLeft = [Int]()
    
    for i in 0..<grids.count {
      leftToRight.append(grids[i][i])
    }
    
    if leftToRight == desiredDiag {
      return true
    }
    
    for i in 0..<grids.count {
      rightToLeft.append(grids.reversed()[i][i])
    }
    
    if rightToLeft == desiredDiag {
      return true
    }
    
    return false
  }
}
