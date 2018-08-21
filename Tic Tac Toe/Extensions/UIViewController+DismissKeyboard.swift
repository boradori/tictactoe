//
//  UIViewController+DismissKeyboard.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/17/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  func hideKeyboardWhenDrag() {
    let drag = UIPanGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    drag.cancelsTouchesInView = false
    view.addGestureRecognizer(drag)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
