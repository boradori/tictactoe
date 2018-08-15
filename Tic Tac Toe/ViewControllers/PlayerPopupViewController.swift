//
//  PlayerPopupViewController.swift
//  Tic Tac Toe
//
//  Created by Youngsun Paik on 8/15/18.
//  Copyright © 2018 Youngsun Paik. All rights reserved.
//

import UIKit
import YPImagePicker

class PlayerPopupViewController: UIViewController {
  var player: Player?
  var gameIsStarted: Bool?
  @IBOutlet weak var playerNameTextField: UITextField!
  @IBOutlet weak var playerSymbolImageView: UIImageView!
  @IBOutlet weak var removePhotoButton: UIButton!
  
  private var imageChanged = false {
    didSet {
      if imageChanged == true {
        removePhotoButton.isHidden = false
        removePhotoButton.isEnabled = true
      } else if imageChanged == false {
        removePhotoButton.isHidden = true
        removePhotoButton.isEnabled = false
      }
    }
  }
  
  var doneSaving: ((_ player: Player) -> ())? // callback function for passing data over to game view controller

  override func viewDidLoad() {
    super.viewDidLoad()
    playerSetup()
    removePhotoButtonSetup()
  }
  
  private func playerSetup() {
    if let player = player {
      playerNameTextField.text = player.name
      playerSymbolImageView.image = player.symbol
    }
    
    addGestures()
  }
  
  private func removePhotoButtonSetup() {
    if player?.number == 1 && gameIsStarted == false {
      if playerSymbolImageView.image != UIImage(assetIdentifier: .cross) {
        removePhotoButton.isHidden = false
        removePhotoButton.isEnabled = true
      }
    } else if player?.number == 2 && gameIsStarted == false {
      if playerSymbolImageView.image != UIImage(assetIdentifier: .nought) {
        removePhotoButton.isHidden = false
        removePhotoButton.isEnabled = true
      }
    }
  }
  
  private func addGestures() {
    let playerSymbolTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerSymbolTapped))
    playerSymbolImageView.addGestureRecognizer(playerSymbolTapGesture)
    
    if gameIsStarted == false {
      playerSymbolImageView.isUserInteractionEnabled = true
    }
  }
  
  @objc private func playerSymbolTapped() {
    // YPImagePicker
    var config = YPImagePickerConfiguration()
    config.library.onlySquare = true
    config.onlySquareImagesFromCamera = true
    config.targetImageSize = .cappedTo(size: 2024)
    config.usesFrontCamera = false
    config.showsFilters = false
    config.shouldSaveNewPicturesToAlbum = false
    config.albumName = "Library"
    config.screens = [.photo, .library]
    config.startOnScreen = .photo
    
    let picker = YPImagePicker(configuration: config)
    picker.didFinishPicking { [unowned picker] items, _ in
      if let photo = items.singlePhoto {
        self.playerSymbolImageView.image = photo.image
        self.imageChanged = true
      }
      picker.dismiss(animated: true, completion: nil)
    }
    present(picker, animated: true, completion: nil)
  }
  
  @IBAction func removePhoto(_ sender: UIButton) {
    if player?.number == 1 {
      playerSymbolImageView.image = UIImage(assetIdentifier: .cross)
    } else {
      playerSymbolImageView.image = UIImage(assetIdentifier: .nought)
    }
    
    imageChanged = false
  }
  
  @IBAction func save(_ sender: UIButton) {
    guard let playerName = playerNameTextField.text else { return }
    guard let playerSymbol = playerSymbolImageView.image else { return }
    
    player?.name = playerName
    player?.symbol = playerSymbol
    
    if let doneSaving = doneSaving {
      doneSaving(player!)
    }
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancel(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
