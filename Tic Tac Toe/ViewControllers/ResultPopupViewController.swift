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
  @IBOutlet weak var gridCountTextField: UITextField!
  
  var game: Game?
  var continuePlaying: ((_ numberInGridTextField: Int) -> ())?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
    hideKeyboardWhenDrag()
    resultLabelSetup()
  }
  
  private func resultLabelSetup() {
    if let game = game {
      resultLabel.text = game.result
    }
  }
  
  @IBAction func yesTapped(_ sender: UIButton) {
    if let numberOfGrids = gridCountTextField.text {
      if Int(numberOfGrids)! < 3 {
        gridCountTextField.placeholder = "Please enter 3 or higher."
      } else if Int(numberOfGrids)! % 2 == 0 {
        gridCountTextField.placeholder = "Please enter an odd number."
      } else {
        if let continuePlaying = continuePlaying {
          continuePlaying(Int(numberOfGrids)!)
        }
      }
    } else {
      if let continuePlaying = continuePlaying {
        continuePlaying(3)
      }
    }
    
    dismissKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func noTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
