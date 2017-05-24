//
//  Model.swift
//  LivesModel
//
//  Created by kkolontay on 5/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit

class ModelField: NSObject {
  var rows = 0
  var columns = 0
  var iteration = 0
  var bodyPopulation = Array<Int>()
  var bodyPopulationNext = Array<Int>()
  var timer: Timer?
  var countOperation = 0
  let poop1 = [1, 0, 0, 0, 1, 1, 1, 1, 0]
  let poop2 = [0, 1, 0, 0, 1, 1, 1, 0, 1]
  let poop3 = [1, 0, 1, 1, 1, 0, 0, 1, 0]
  let poop4 = [0, 1, 1, 1, 1, 0, 0, 0, 1]
  var poops: Array<Any>?
  weak var delegate: DataChanged?
  
  init(_ rows: Int, columns: Int, iteration: Int) {
    super.init()
    self.rows = rows
    self.columns = columns
    self.iteration = iteration
    clearField()
    poops = [poop1, poop2, poop3, poop4]
    countOperation = 1
    timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(generateNextGeneration), userInfo: nil, repeats: true)
  }
  
  func generateNextGeneration() {
    print("hello")
    countOperation += 1
    for row in 0 ..< rows {
      for column in 0 ..< columns {
        setStateForBody(row, column: column)
      }
    }
    if !fieldIsChanged() || countOperation > iteration {
      timer?.invalidate()
      timer = nil
    } else {
      bodyPopulation =  bodyPopulationNext
      delegate?.renewField(bodyPopulation)
    }
  }
  
  func restartTimer() {
    if timer != nil {
      timer?.invalidate()
      timer = nil
    }
    countOperation = 0 
     timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(generateNextGeneration), userInfo: nil, repeats: true)
  }
  
  func setPoopOnField() {
    let rowPlace = Int(arc4random_uniform(UInt32(rows)))
    let columnPlace = Int(arc4random_uniform(UInt32(columns)))
    let typePoop = Int(arc4random_uniform(4))
    let poop: Array<Int> = poops?[typePoop] as! Array<Int>
    var startIndex = rowPlace * columnPlace + columnPlace
    if startIndex > bodyPopulation.count - 10 {
      startIndex = bodyPopulation.count  - 10
    }
    for index in startIndex ... startIndex + 8  {
      bodyPopulationNext[index] = poop[index - startIndex]
    }
  }
  
  func setManyPoops() {
    let count = Int(arc4random_uniform(150)) + 1
    for _ in 0 ... count {
      setPoopOnField()
    }
  }
  
  func clearField() {
    if timer != nil {
      timer?.invalidate()
      timer = nil
    }
    bodyPopulationNext = Array<Int>()
    bodyPopulation = Array<Int>()
    for _ in 0 ..< rows {
      for _ in 0 ..< columns {
        bodyPopulation.append(0)
        bodyPopulationNext.append(0)
      }
    }
    delegate?.renewField(bodyPopulation)
  }
  
  func setStateForBody(_ row: Int, column: Int) {
    var livesCount = 0
    for rowNeighbors in row - 1 ... row + 1 {
      for columnNeighbors in column - 1 ... column + 1 {
        if rowNeighbors < 0 || rowNeighbors > rows - 1 || columnNeighbors < 0 || columnNeighbors > columns - 1 {
          continue
        }
        if bodyPopulation[ rowNeighbors * columnNeighbors + columnNeighbors] == 1 {
          livesCount += 1
        }
      }
    }
    if bodyPopulation[row * column + column] == 0 && livesCount == 3 {
      bodyPopulationNext[row * column + column] = 1
    }
    if bodyPopulation[row * column + column] == 1 && (livesCount > 3  || livesCount < 2) {
      bodyPopulationNext[row * column + column] = 0
    }
  }
  
  func fieldIsChanged() -> Bool {
    for index in 0 ..< rows * columns {
      if bodyPopulationNext[index] != bodyPopulation[index] {
        return true
      }
    }
    return false
  }
}
