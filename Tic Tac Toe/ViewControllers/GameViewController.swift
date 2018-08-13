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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  
  
  
  
  
  
  @IBAction func openMenu(_ sender: UIBarButtonItem) {
    menuLeadingConstraint.constant = menuLeadingConstraint.constant == 0 ? -140 : 0
    UIView.animate(withDuration: 0.2) {
      self.view.layoutIfNeeded()
    }
  }
  

}

