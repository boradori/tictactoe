//
//  ResultPopupViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/15/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class ResultPopupViewController: UIViewController {
  @IBOutlet weak var resultLabel: UILabel!
  var game: Game?
  var continuePlaying: (() -> ())?

  override func viewDidLoad() {
    super.viewDidLoad()
    resultLabelSetup()
  }
  
  private func resultLabelSetup() {
    if let game = game {
      resultLabel.text = game.result
    }
  }
  
  @IBAction func yesTapped(_ sender: UIButton) {
    if let continuePlaying = continuePlaying {
      continuePlaying()
    }
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func noTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
