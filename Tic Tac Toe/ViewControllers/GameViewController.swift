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
  
  @IBOutlet weak var gridCountTextField: UITextField!
  @IBOutlet weak var backgroundButton: UIButton! // to dismiss sidebar by tapping on screen
  @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var playerOneCardView: PlayerCardView!
  @IBOutlet weak var playerTwoCardView: PlayerCardView!
  
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
  }
  
  private func removeCellImages() { // parameter collection view
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
    removeCellImages()
    game = Game(name: gameName, result: nil, board: board, players: [playerOne, playerTwo])
    activePlayer = game.players![0].number
    
    dismissKeyboard()
    slideSidebar(closeOnly: true)
  }
  
  
  // MARK: - Check winning conditions
  
  private func checkRow(_ board: Board, row: Int, col: Int, playerNumber: Int) {
    let numberOfRowsAndCols = board.grids.count
    let desiredRow = Array(repeating: playerNumber, count: numberOfRowsAndCols)
    
    if board.grids[row] == desiredRow {
      let player = game.players!.first(where: {$0.number == playerNumber})
      saveGame(player)
      showResult()
    } else {
      if board.grids.indices.contains(col + 1) && board.grids[row][col] == board.grids[row][col + 1] {
        checkRow(board, row: row, col: col + 1, playerNumber: playerNumber)
      }
    }
  }
  
  private func checkCol(_ board: Board, row: Int, col: Int, playerNumber: Int) {
    let numberOfRowsAndCols = board.grids.count
    let desiredCol = Array(repeating: playerNumber, count: numberOfRowsAndCols)
    
    if board.grids.map({$0[col]}) == desiredCol {
      let player = game.players!.first(where: {$0.number == playerNumber})
      saveGame(player)
      showResult()
    } else {
      if board.grids.indices.contains(row + 1) && board.grids[row][col] == board.grids[row + 1][col] {
        checkCol(board, row: row + 1, col: col, playerNumber: playerNumber)
      }
    }
  }
  
  private func checkDiag(_ board: Board, playerNumber: Int) {
    let numberOfRowsAndCols = board.grids.count
    let desiredDiag = Array(repeating: playerNumber, count: numberOfRowsAndCols)
    
    var leftToRight = [Int]()
    var rightToLeft = [Int]()

    for i in 0..<numberOfRowsAndCols {
      leftToRight.append(board.grids[i][i])
    }
    
    if leftToRight == desiredDiag {
      let player = game.players!.first(where: {$0.number == playerNumber})
      saveGame(player)
      showResult()
    }
    
    for i in 0..<numberOfRowsAndCols {
      rightToLeft.append(board.grids.reversed()[i][i])
    }
    
    if rightToLeft == desiredDiag {
      let player = game.players!.first(where: {$0.number == playerNumber})
      saveGame(player)
      showResult()
    }
  }
  
  private func checkEndOfIndex(_ board: Board) {
    let numberOfRowsAndCols = board.grids.count
    if board.moveIndex == (numberOfRowsAndCols * numberOfRowsAndCols) - 1  && game.result == nil {
      saveGame(nil)
      showResult()
    }
  }
  
  private func changeTurn(_ players: [Player]) -> [Player] {
    var playersList = players
    playersList.append(playersList.removeFirst())
    
    return playersList
  }
  
  
  // MARK: - Save Game
  
  private func saveGame(_ winner: Player?) {
    guard let winner = winner else {
      game.result = "Draw!"
      game.board = board
      games.append(game)
      return
    }
    
    game.result = "\(winner.name) wins!"
    
    if winner.number == playerOne.number {
      playerOne.wins += 1
      playerOneCardView.playerWinCountLabel.text = "\(playerOne.wins)"
    } else if winner.number == playerTwo.number {
      playerTwo.wins += 1
      playerTwoCardView.playerWinCountLabel.text = "\(playerTwo.wins)"
    }
    
    game.board = board
    games.append(game)
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
      
      // place player number on grid
      board?.grids[indexPath.section][indexPath.item] = activePlayer // current player
      
      // check winning conditions
      checkRow(board!, row: indexPath.section, col: indexPath.item, playerNumber: activePlayer)
      checkCol(board!, row: indexPath.section, col: indexPath.item, playerNumber: activePlayer)
      checkDiag(board!, playerNumber: activePlayer)
      
      checkEndOfIndex(board!)

      board?.moveIndex += 1
      
      // change turn
      game.players = changeTurn(game.players!)
      activePlayer = (game.players?.first?.number)!
    }
  }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let marginsAndInsets = 10 * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + 10 * CGFloat((board?.grids.count)! - 1)
    let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat((board?.grids.count)!)).rounded(.down)
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
