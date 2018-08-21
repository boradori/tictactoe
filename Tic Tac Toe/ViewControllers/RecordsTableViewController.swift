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
    }

    return cell
  }
}
