//
//  UIImage+AssetIdentifier.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/12/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

extension UIImage {
  enum AssetIdentifier: String {
    case cross = "cross"
    case nought = "nought"
    case cancelButton = "cancelButton"
    case emptyGrid = "emptyGrid"
    
    static let values = [cross, nought, cancelButton, emptyGrid]
  }
  
  convenience init!(assetIdentifier: AssetIdentifier) {
    self.init(named: assetIdentifier.rawValue)
  }
}
