//
//  GameViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/11/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  var board = Board(grids: [0, 0, 0, 0, 0, 0, 0, 0, 0])
  
  var playerOne = PlayerOne(name: "Player 1", symbol: UIImage(assetIdentifier: .cross), wins: 0)
  var playerTwo = PlayerTwo(name: "Player 2", symbol: UIImage(assetIdentifier: .nought), wins: 0)
  
  private var activePlayer = 1 {
    didSet {
      if activePlayer == 1 {
        playerOneCardView.playerCardFrame.layer.borderColor = UIColor.black.cgColor
        playerOneCardView.playerCardFrame.layer.borderWidth = 4.0
        
        playerTwoCardView.playerCardFrame.layer.borderColor = UIColor.white.cgColor
        playerTwoCardView.playerCardFrame.layer.borderWidth = 0.0
      } else {
        playerOneCardView.playerCardFrame.layer.borderColor = UIColor.white.cgColor
        playerOneCardView.playerCardFrame.layer.borderWidth = 0.0
        
        playerTwoCardView.playerCardFrame.layer.borderColor = UIColor.black.cgColor
        playerTwoCardView.playerCardFrame.layer.borderWidth = 4.0
      }
    }
  }
  
  @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var playerOneCardView: PlayerCardView!
  @IBOutlet weak var playerTwoCardView: PlayerCardView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    playerCardSetup()
  }
  
  
  // MARK: - Setup
  
  private func playerCardSetup() {
    playerOneCardView.playerNameLabel.text = playerOne.name
    playerOneCardView.playerSymbolImageView.image = playerOne.symbol
    playerOneCardView.playerWinCountLabel.text = "Wins: \(playerOne.wins)"
    
    playerTwoCardView.playerNameLabel.text = playerTwo.name
    playerTwoCardView.playerSymbolImageView.image = playerTwo.symbol
    playerTwoCardView.playerWinCountLabel.text = "Wins: \(playerTwo.wins)"
    
    playerOneCardView.playerCardFrame.layer.borderColor = UIColor.black.cgColor
    playerOneCardView.playerCardFrame.layer.borderWidth = 4.0
    
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

  
  @IBAction func placeSymbol(_ sender: UIButton) {
    if board.grids[sender.tag - 1] == 0 {
      board.grids[sender.tag - 1] = activePlayer
      
      if activePlayer == 1 {
        sender.setImage(UIImage(assetIdentifier: .cross), for: UIControlState())
        
        activePlayer = 2
      } else {
        sender.setImage(UIImage(assetIdentifier: .nought), for: UIControlState())
        activePlayer = 1
      }
    }
  }
  
}

