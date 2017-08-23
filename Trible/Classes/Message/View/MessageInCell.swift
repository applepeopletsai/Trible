//
//  MessageInCell.swift
//  Trible
//
//  Created by Daniel on 2017/8/15.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class MessageInCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
