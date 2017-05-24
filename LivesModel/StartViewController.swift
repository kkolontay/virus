//
//  ViewController.swift
//  LivesModel
//
//  Created by kkolontay on 5/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

  @IBOutlet weak var iterationTextField: UITextField!
  @IBOutlet weak var heightTextField: UITextField!
  @IBOutlet weak var widthTextField: UITextField!
  var width = 200
  var height = 500
  var iteration = 5000
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear( animated)
    navigationController?.navigationBar.isHidden = true
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    width = returnValue(widthTextField.text ?? "", defaultValue: 200, minValue: 50)
    height = returnValue(heightTextField.text ?? "", defaultValue: 500, minValue: 125)
    iteration = returnValue(iterationTextField.text ?? "", defaultValue: 5000, minValue: 1)
    
    if segue.identifier == "game" {
      let controller = segue.destination as! PlayFieldViewController
      controller.width = width
      controller.height = height
      controller.iteration = iteration
    }
}

  @IBAction func goButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: "game", sender: nil)
  }
  
  func returnValue(_ value: String, defaultValue: Int, minValue: Int) -> Int {
    guard let item = Int(value) else {
      return defaultValue
    }
    if item >= minValue && item <= defaultValue {
      return item
    }
    return defaultValue
  }
}

