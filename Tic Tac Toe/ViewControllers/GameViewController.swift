//
//  GameViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/11/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  private var gameCount = 0
  private var game = Game(name: "Game 1", result: nil, board: nil, players: nil)
  
  var games = [Game]()
  
  private var board: Board?
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
  
  private var activePlayer = 1 { // activePlayer = game.activePlayer
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
  
  @IBOutlet weak var gridCountTextField: UITextField!
  @IBOutlet weak var backgroundButton: UIButton! // to dismiss sidebar by tapping on screen
  @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var playerOneCardView: PlayerCardView!
  @IBOutlet weak var playerTwoCardView: PlayerCardView!
  
  private var itemsPerRowAndCol = 3
  
  private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Game 1"
    playerCardSetup()
    
    hideKeyboardWhenTappedAround()
    hideKeyboardWhenDrag()
    startNewGame(numberOfRowsAndCols: 3)
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
  
  
  // MARK: - Game Logic
  
  private func createBoard(_ numberOfRowsAndCols: Int) {
    let grids = Array(repeating: Array(repeating: 0, count: numberOfRowsAndCols), count: numberOfRowsAndCols)
    board = Board(grids: grids, numberOfGrids: numberOfRowsAndCols * numberOfRowsAndCols, moveIndex: 0)
    
    removeCellImages()
  }
  
  private func removeCellImages() {
    // remove imageView from all cell's contentView
    for i in 0..<collectionView.visibleCells.count {
      collectionView.visibleCells[i].isUserInteractionEnabled = true
      if let symbolImageView = collectionView.visibleCells[i].contentView.subviews.first {
        symbolImageView.removeFromSuperview()
      }
    }
    
    collectionView.reloadData()
  }
  
  
  // MARK: - Start New Game

  private func startNewGame(numberOfRowsAndCols: Int) {
    gameIsStarted = false
    gameCount += 1
    let gameName = "Game \(gameCount)"
    title = gameName
    createBoard(numberOfRowsAndCols)
    game = Game(name: gameName, result: nil, board: board, players: [playerOne, playerTwo])
    activePlayer = game.players![0].number

    gameIsActive = true
    
    dismissKeyboard()
    slideSidebar(closeOnly: true)
  }
  
  
  // MARK: - Check winning conditions
  
  private func checkWinningConditions(_ board: Board, playerNumber: Int) {
    let numberOfRowsAndCols = board.grids.count

    var rowCrossed = 0
    var colCrossed = 0
    var diagRToLCrossed = 0
    var diagLToRCrossed = numberOfRowsAndCols - 1
    for i in 0..<numberOfRowsAndCols {
      while rowCrossed <= numberOfRowsAndCols && colCrossed <= numberOfRowsAndCols && diagRToLCrossed <= numberOfRowsAndCols && diagLToRCrossed >= 0 {
        if rowCrossed == numberOfRowsAndCols - 1 || colCrossed == numberOfRowsAndCols - 1 || diagRToLCrossed == numberOfRowsAndCols - 1 || diagLToRCrossed == 0 {
          print("Player \(playerNumber) wins!")
          break
        } else if board.grids[i][rowCrossed] == playerNumber && board.grids[i][rowCrossed] == board.grids[i][rowCrossed + 1] {
          rowCrossed += 1
        } else if board.grids[colCrossed][i] == playerNumber && board.grids[colCrossed][i] == board.grids[colCrossed + 1][i] {
          colCrossed += 1
        } else if board.grids.indices.contains(diagRToLCrossed + 1) && board.grids.indices.contains(i + 1) && board.grids[i][diagRToLCrossed] == playerNumber && board.grids[i][diagRToLCrossed] == board.grids[i + 1][diagRToLCrossed + 1] {
          diagRToLCrossed += 1
        } else if board.grids.indices.contains(diagLToRCrossed - 1) && board.grids.indices.contains(i + 1) && board.grids[i][diagLToRCrossed] == playerNumber && board.grids[i][diagLToRCrossed] == board.grids[i + 1][diagLToRCrossed - 1]  {
          diagLToRCrossed -= 1
        } else {
          break
        }
      }
    }
  }
  
  private func changeTurn(_ players: [Player]) -> [Player] {
    var playersList = players
    playersList.append(playersList.removeFirst())
    
    return playersList
  }
  
  
  // MARK: - Show Result
  
  private func showResult() {
    let storyboard = UIStoryboard(name: "ResultPopup", bundle: nil)
    if let vc = storyboard.instantiateViewController(withIdentifier: "resultPopupVC") as? ResultPopupViewController {
      vc.game = game
      vc.continuePlaying = continuePlaying
      
      present(vc, animated: true, completion: nil)
    }
  }
  
  private func continuePlaying(_ numberInGridTextField: Int) {
    startNewGame(numberOfRowsAndCols: numberInGridTextField)
  }
  
  // MARK: - Save Game
  
  //  private func saveGame(_ winner: Player?) {
  //    if winner?.number == playerOne.number {
  //      playerOne.wins += 1
  //    } else if winner?.number == playerTwo.number {
  //      playerTwo.wins += 1
  //    }
  //
  //    game.board = board
  //    games.append(game)
  //  }
  
  
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
    guard let numberOfGrids = gridCountTextField.text else {
      return
    }
    
    if numberOfGrids.isEmpty {
      print("You must enter number of grids")
    } else if Int(numberOfGrids)! >= 3 && Int(numberOfGrids)! % 2 != 0 {
      startNewGame(numberOfRowsAndCols: Int(numberOfGrids)!)
    } else {
      print("Number of grids has to be greater than or equal to 3 and odd number.")
    }
  }
  
  @IBAction func tapToDismissSlidebar(_ sender: UIButton) {
    slideSidebar(closeOnly: true)
  }

  
  // MARK: - Collection View data source
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return (board?.grids.count)!
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (board?.grids[section].count)!
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
    cell.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 237/255, alpha: 1.0)
    return cell
  }
  
  
  // MARK: - Collection View delegate
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if board?.grids[indexPath.section][indexPath.item] == 0 {
      let cell = collectionView.cellForItem(at: indexPath)
      let imageview: UIImageView = UIImageView(frame: CGRect(x: (cell?.contentView.bounds.minX)!, y: (cell?.contentView.bounds.minY)!, width: (cell?.contentView.bounds.width)!, height: (cell?.contentView.bounds.height)!));
      imageview.image = activePlayer == 1 ? UIImage(assetIdentifier: .cross) : UIImage(assetIdentifier: .nought)
      
      cell?.contentView.addSubview(imageview)
      cell?.isUserInteractionEnabled = false
      
      // place the grid with player number
      board?.grids[indexPath.section][indexPath.item] = activePlayer // current player
      board?.moveIndex += 1
      
      checkWinningConditions(board!, playerNumber: activePlayer)
      
      // change turn
      game.players = changeTurn(game.players!)
      activePlayer = (game.players?.first?.number)!
    }
  }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let marginsAndInsets = 10 * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + 10 * CGFloat(itemsPerRowAndCol - 1)
    let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(itemsPerRowAndCol)).rounded(.down)
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
