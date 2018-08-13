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
    
    static let values = [cross, nought]
  }
  
  convenience init!(assetIdentifier: AssetIdentifier) {
    self.init(named: assetIdentifier.rawValue)
  }
}
