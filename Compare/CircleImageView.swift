//
//  CircleImageView.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/13.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

  @IBInspectable var borderColor :  UIColor = UIColor.black
  @IBInspectable var borderWidth :  CGFloat = 0.1
  
  override var image: UIImage? {
    didSet{
      layer.masksToBounds = false
      layer.borderColor = borderColor.cgColor
      layer.borderWidth = borderWidth
      layer.cornerRadius = frame.height/2
      clipsToBounds = true
    }
  }
  
  

}
