//
//  PlayFieldViewController.swift
//  LivesModel
//
//  Created by kkolontay on 5/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit

protocol DataChanged: class {
  func renewField(_ array: Array<Int>)
}

class PlayFieldViewController: UIViewController {
  var width = 200
  var height = 500
  var iteration = 5000
  var gameField: FieldView?
  var model: ModelField?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear( animated)
     navigationController?.navigationBar.isHidden = false
    setGamesFieldSize()
  }
  
  func setGamesFieldSize() {
    let widthScreen = UIScreen.main.bounds.width
    let heightScreen = UIScreen.main.bounds.height
    if Int(heightScreen) - 104 < height {
      height = Int(heightScreen) - 104
    }
    let widthFiled = (Double(width / 3)).rounded(.down)
    let heightFiell = (Double(height / 3)).rounded(.down)
    height = Int(heightFiell) * 3
    width = Int(widthFiled) * 3
    let y = 65
    let x = (Int(widthScreen) - width) / 2
   
    gameField = FieldView(frame: CGRect(x: x, y: y, width: width, height: height))
    gameField?.backgroundColor = .white
    model = ModelField((gameField?.rows)!, columns: (gameField?.columns)!, iteration: iteration)
    model?.delegate = self
    view.addSubview(gameField!)
    gameField?.setView()
  }
  
  @IBAction func clearFieldButtonPressed(_ sender: Any) {
    model?.clearField()
  }
  
  @IBAction func poopOnceButtonPressed(_ sender: Any) {
    model?.setPoopOnField()
    model?.restartTimer()
  }
  
  @IBAction func poopRandomlyButtonPressed(_ sender: Any) {
    model?.setManyPoops()
    model?.restartTimer()
  }
  
}

extension PlayFieldViewController: DataChanged {
  func renewField(_ array: Array<Int>) {
    for item in 0 ..< array.count {
      gameField?.setLivePoints(item, isLive: array[item] == 1 ? true: false)
    }
  }
}
