//
//  CustomTableViewCell2.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/18.
//  Copyright © 2017年 mirai. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell2: UITableViewCell {
  
  

  @IBOutlet weak var ImageArray: UIImageView!

  @IBOutlet weak var LabelArray: UILabel!
  

  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
