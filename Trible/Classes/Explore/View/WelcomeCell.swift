//
//  WelcomeCell.swift
//  Trible
//
//  Created by Daniel on 2017/7/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

protocol WelcomeCellDelegate {
    func exploreButtonPress()
}

class WelcomeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate:WelcomeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = "安安你好"
    }
    
    @IBAction func exploreButtonPress(_ sender: UIButton) {
        self.delegate?.exploreButtonPress()
    }    

}
