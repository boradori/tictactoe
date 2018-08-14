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
    
    static let values = [cross, nought, cancelButton]
  }
  
  convenience init!(assetIdentifier: AssetIdentifier) {
    self.init(named: assetIdentifier.rawValue)
  }
}
