//
//  PlayerPopupViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/15/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class PlayerPopupViewController: UIViewController {
  var player: Player?
  @IBOutlet weak var playerNameTextField: UITextField!
  @IBOutlet weak var playerSymbolImageView: UIImageView!
  @IBOutlet weak var removePhotoButton: UIButton!
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  private func setup() {
    if let player = player {
      playerNameTextField.text = player.name
      playerSymbolImageView.image = player.symbol
    }
  }
  
  @IBAction func removePhoto(_ sender: UIButton) {
  }
  
  @IBAction func save(_ sender: UIButton) {
  }
  
  @IBAction func cancel(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
