//
//  GameViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/11/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var playerOneCardView: PlayerCardView!
  @IBOutlet weak var playerTwoCardView: PlayerCardView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    playerCardSetup()
  }
  
  
  // MARK: - Setup
  
  private func playerCardSetup() {
    playerOneCardView.playerNameLabel.text = "Player 1"
    playerOneCardView.playerSymbolImageView.image = UIImage(assetIdentifier: .cross)
    playerOneCardView.playerWinCountLabel.text = "Wins: 0"
    
    playerTwoCardView.playerNameLabel.text = "Player 2"
    playerTwoCardView.playerSymbolImageView.image = UIImage(assetIdentifier: .nought)
    playerTwoCardView.playerWinCountLabel.text = "Wins: 0"
    
    addGestures()
  }
  
  private func addGestures() {
    let playerOneCardTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerOneCardTapped))
    let playerTwoCardTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerTwoCardTapped))
    
    playerOneCardView.addGestureRecognizer(playerOneCardTapGesture)
    playerTwoCardView.addGestureRecognizer(playerTwoCardTapGesture)
  }
  
  
  @IBAction func openMenu(_ sender: UIBarButtonItem) {
    menuLeadingConstraint.constant = menuLeadingConstraint.constant == 0 ? -140 : 0
    UIView.animate(withDuration: 0.2) {
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func playerOneCardTapped() {
  }
  
  @objc private func playerTwoCardTapped() {
  }

  
  private func presentPlayerCardPopup(_ playerNumber: Int) {
  }

  
}

