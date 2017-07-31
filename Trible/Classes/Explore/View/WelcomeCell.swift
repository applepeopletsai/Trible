//
//  WelcomeCell.swift
//  Trible
//
//  Created by Daniel on 2017/7/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class WelcomeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = "安安你好"
    }
    
    @IBAction func exploreButtonPress(_ sender: UIButton) {
        
    }
    

}
