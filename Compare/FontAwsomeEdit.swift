//
//  FontAwsomeEdit.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/16.
//  Copyright © 2017年 mirai. All rights reserved.
//

import Foundation
import FontAwesome_swift
import UIKit

class FontAwesomeEdit: UITabBarController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tabBar.items![0].image = UIImage.fontAwesomeIcon(name: .chevronUp
      , textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), size: CGSize (width:30, height:30))
    self.tabBar.items![0].title = "比較する"
    
    self.tabBar.items![1].image = UIImage.fontAwesomeIcon(name: .pencilSquareO, textColor: #colorLiteral(red: 0.4150432705, green: 1, blue: 0.3595192446, alpha: 1), size: CGSize (width:30, height:30))
    self.tabBar.items![1].title = "メモ"
    
    self.tabBar.items![2].image = UIImage.fontAwesomeIcon(name: .star, textColor: #colorLiteral(red: 0.4150432705, green: 1, blue: 0.3595192446, alpha: 1), size: CGSize (width:30, height:30))
    self.tabBar.items![2].title = "お気に入り"
    
    
    
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  
}
