//
//  RecordsTableViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/16/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

class RecordsTableViewController: UITableViewController {
  var games = [Game]()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewSetup()
  }
  
  
  // MARK: - Setup
  
  private func tableViewSetup() {
    title = "Records"
    tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.height
    tableView.separatorStyle = .singleLine
    tableView.tableFooterView = UIView() // invisible footer to remove separator line in empty cells
    tableView.rowHeight = 100.0
    
    tableView.register(UINib(nibName: "RecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordCell")
  }


  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let game = games[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
    if let recordCell = cell as? RecordsTableViewCell {
      recordCell.gameNameLabel.text = game.name
      recordCell.gameResultLabel.text = game.result
      
      if game.board?.grids[0] == 1 {
        recordCell.grid0.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[0] == 2 {
        recordCell.grid0.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[1] == 1 {
        recordCell.grid1.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[1] == 2 {
        recordCell.grid1.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[2] == 1 {
        recordCell.grid2.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[2] == 2 {
        recordCell.grid2.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[3] == 1 {
        recordCell.grid3.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[3] == 2 {
        recordCell.grid3.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[4] == 1 {
        recordCell.grid4.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[4] == 2 {
        recordCell.grid4.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[5] == 1 {
        recordCell.grid5.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[5] == 2 {
        recordCell.grid5.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[6] == 1 {
        recordCell.grid6.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[6] == 2 {
        recordCell.grid6.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[7] == 1 {
        recordCell.grid7.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[7] == 2 {
        recordCell.grid7.image = UIImage(assetIdentifier: .nought)
      }
      
      if game.board?.grids[8] == 1 {
        recordCell.grid8.image = UIImage(assetIdentifier: .cross)
      } else if game.board?.grids[8] == 2 {
        recordCell.grid8.image = UIImage(assetIdentifier: .nought)
      }
    }

    return cell
  }
}
