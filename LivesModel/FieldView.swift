//
//  FieldView.swift
//  LivesModel
//
//  Created by kkolontay on 5/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit

class FieldView: UIView {
  let width = 3
  let height = 3
  var rows: Int {
    return Int(frame.height) / 3
  }
  var columns: Int {
    return Int(frame.width) / 3
  }
  var listOfView: Array<UIView>?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    listOfView = Array<UIView>()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func setLivePoints(_ index: Int,  isLive: Bool) {
    listOfView?[index].backgroundColor = isLive ? UIColor.black: UIColor.white
    listOfView?[index].setNeedsDisplay()
  }
  
  func setView() {
    for row in 0 ..< rows {
      for column in 0 ..< columns {
        let item = UIView(frame: CGRect(x: width * column, y: row * height, width: width, height: height))
        listOfView?.append(item)
        item.backgroundColor = .white
        self.addSubview(item)
      }
    }
  }
}
