//
//  RecordsTableViewCell.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/16/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {
  @IBOutlet weak var gameNameLabel: UILabel!
  @IBOutlet weak var gameResultLabel: UILabel!
  
  @IBOutlet weak var grid0: UIImageView!
  @IBOutlet weak var grid1: UIImageView!
  @IBOutlet weak var grid2: UIImageView!
  @IBOutlet weak var grid3: UIImageView!
  @IBOutlet weak var grid4: UIImageView!
  @IBOutlet weak var grid5: UIImageView!
  @IBOutlet weak var grid6: UIImageView!
  @IBOutlet weak var grid7: UIImageView!
  @IBOutlet weak var grid8: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
}
