//
//  GameViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/11/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  private var gameCount = 1
  private var game = Game(name: "Game 1", result: nil, board: nil)
  
  var games = [Game]()
  
  private var board = Board()
  private var gameIsActive = true
  private var gameIsStarted = false
  
  private var playerOne = Player(number: 1, name: "Player 1", symbol: UIImage(assetIdentifier: .cross), wins: 0) {
    didSet {
      playerOneCardView.playerNameLabel.text = playerOne.name
    }
  }
  private var playerTwo = Player(number: 2, name: "Player 2", symbol: UIImage(assetIdentifier: .nought), wins: 0) {
    didSet {
      playerTwoCardView.playerNameLabel.text = playerTwo.name
    }
  }
  
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
  
  @IBOutlet weak var backgroundButton: UIButton! // to dismiss sidebar by tapping on screen
  @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var playerOneCardView: PlayerCardView!
  @IBOutlet weak var playerTwoCardView: PlayerCardView!
  
  private let itemsPerRow = 5
  
  private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Game 1"
    playerCardSetup()
    collectionViewSetup()
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
    
    playerOneCardView.playerCardFrame.addRoundedCorners()
    playerTwoCardView.playerCardFrame.addRoundedCorners()
    
    addGestures()
  }
  
  private func addGestures() {
    let playerOneCardTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerOneCardTapped))
    let playerTwoCardTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerTwoCardTapped))
    
    playerOneCardView.addGestureRecognizer(playerOneCardTapGesture)
    playerTwoCardView.addGestureRecognizer(playerTwoCardTapGesture)
  }
  
  @objc private func playerOneCardTapped() {
    let storyboard = UIStoryboard(name: "PlayerPopup", bundle: nil)
    if let vc = storyboard.instantiateViewController(withIdentifier: "playerPopupVC") as? PlayerPopupViewController {
      vc.player = playerOne
      vc.gameIsStarted = gameIsStarted
      vc.doneSaving = doneSaving
      
      present(vc, animated: true, completion: nil)
    }
  }
  
  @objc private func playerTwoCardTapped() {
    let storyboard = UIStoryboard(name: "PlayerPopup", bundle: nil)
    if let vc = storyboard.instantiateViewController(withIdentifier: "playerPopupVC") as? PlayerPopupViewController {
      vc.player = playerTwo
      vc.gameIsStarted = gameIsStarted
      vc.doneSaving = doneSaving
      
      present(vc, animated: true, completion: nil)
    }
  }
  
  private func doneSaving(_ player: Player) {
    if player.number == 1 {
      playerOne = player
    } else {
      playerTwo = player
    }
  }
  
  private func collectionViewSetup() {
//    guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//    flowLayout.minimumInteritemSpacing = margin
//    flowLayout.minimumLineSpacing = margin
//    flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
//
//    collectionView.contentInsetAdjustmentBehavior = .always
//    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
  }
  
  private func slideSidebar(closeOnly: Bool) {
    if closeOnly == true {
      backgroundButton.alpha = 0.0
      menuLeadingConstraint.constant = -140
    } else {
      if menuLeadingConstraint.constant == 0 {
        backgroundButton.alpha = 0.0
        menuLeadingConstraint.constant = -140
      } else if menuLeadingConstraint.constant == -140 {
        backgroundButton.alpha = 0.5
        menuLeadingConstraint.constant = 0
      }
    }
    
    UIView.animate(withDuration: 0.2) {
      self.view.layoutIfNeeded()
    }
  }
  
  
  // MARK: - Save Game
  
  private func saveGame(_ winner: Player?) {
    if winner?.number == playerOne.number {
      playerOne.wins += 1
    } else if winner?.number == playerTwo.number {
      playerTwo.wins += 1
    }
    
    game.board = board
    games.append(game)
  }
  
  
  // MARK: - Start New Game
  
  private func startNewGame() {
    gameIsStarted = false
    gameCount += 1
    let gameName = "Game \(gameCount)"
    title = gameName
    board = Board()
    game = Game(name: gameName, result: nil, board: board)
    
    gameIsActive = true
    activePlayer = 1
    
    for i in 1...9 {
      let button = view.viewWithTag(i) as! UIButton
      button.setImage(UIImage(assetIdentifier: .emptyGrid), for: UIControlState())
    }
    
    slideSidebar(closeOnly: true)
  }
  
  
  // MARK: - Show Result
  
  private func showResult() {
    let storyboard = UIStoryboard(name: "ResultPopup", bundle: nil)
    if let vc = storyboard.instantiateViewController(withIdentifier: "resultPopupVC") as? ResultPopupViewController {
      vc.game = game
      vc.continuePlaying = { [weak self] in
        self?.startNewGame()
      }
      
      present(vc, animated: true, completion: nil)
    }
  }
  
  
  // MARK: - Actions
  
  @IBAction func openMenu(_ sender: UIBarButtonItem) {
    slideSidebar(closeOnly: false)
  }
  
  @IBAction func openRecords(_ sender: UIBarButtonItem) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let vc = storyboard.instantiateViewController(withIdentifier: "recordsVC") as? RecordsTableViewController {
      vc.games = games
      
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  @IBAction func newGameTapped(_ sender: UIButton) {
    startNewGame()
  }
  
  @IBAction func tapToDismissSlidebar(_ sender: UIButton) {
    slideSidebar(closeOnly: true)
  }

  
  // MARK: - Collection View data source
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return itemsPerRow
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemsPerRow
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
    cell.backgroundColor = UIColor.orange
    return cell
  }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let marginsAndInsets = 10 * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + 10 * CGFloat(itemsPerRow - 1)
    let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(itemsPerRow)).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
