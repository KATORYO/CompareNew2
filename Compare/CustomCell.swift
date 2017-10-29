//
//  CustomCell.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {
  
    
  
  @IBOutlet var imgSample:UIImageView!
  @IBOutlet var lblSample:UILabel!
  
  @IBOutlet weak var myLabel1_2: UILabel!
  @IBOutlet weak var myImage1_2: UIImageView!
  
  
  @IBOutlet weak var sectionLabel: UILabel!
  
  
  
  
  override init(frame: CGRect){
    super.init(frame: frame)
  }
  required init(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)!
  }
}
