//
//  PlayerCardView.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/13/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class PlayerCardView: UIView {
  private var view: UIView!
  
  @IBOutlet weak var playerCardFrame: UIView!
  @IBOutlet weak var playerNameLabel: UILabel!
  @IBOutlet weak var playerWinCountLabel: UILabel!
  @IBOutlet weak var playerSymbolImageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  private func xibSetup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
  }
  
  private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "PlayerCardView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }
}
