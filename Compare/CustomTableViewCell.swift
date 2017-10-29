//
//  CustomTableViewCell.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/22.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  @IBOutlet weak var ProductsImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var PesoLabel: UILabel!
  @IBOutlet weak var YenLabel: UILabel!
  
  
  @IBOutlet weak var phpLabel: UILabel!
  
  @IBOutlet weak var YenUnitLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
