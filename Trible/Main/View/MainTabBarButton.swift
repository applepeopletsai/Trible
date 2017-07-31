//
//  MainTabBarButton.swift
//  Trible
//
//  Created by Daniel on 2017/7/9.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

protocol MainTabBarButtonDelegate: class {
    func mainTabBarButtonPressedWith(mainTabBarButton: MainTabBarButton)
}

class MainTabBarButton: UIView {
    
    // MARK: Property
    weak var delegate: MainTabBarButtonDelegate?
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconTitleLabel: UILabel!
    
    /* 設置button點擊狀態 */
    var _selected:Bool? = false
    var selected:Bool? {
        get {
            return _selected
        }
        set {
            _selected = newValue
            self.iconImageView?.isHighlighted = newValue!
            self.iconTitleLabel?.textColor = (newValue!) ? UIColor.black : UIColor.gray
        }
    }
    
    // MARK: Initailize
    // 初始化Button
    static func initWith(title:String, unSelectImageName:String, selectImageName:String) -> MainTabBarButton {
        let tabBarButton = Bundle.main.loadNibNamed("MainTabBarButton", owner: nil, options: nil)?.first as! MainTabBarButton
        
        tabBarButton.iconTitleLabel.text = title
        tabBarButton.iconTitleLabel.textColor = (tabBarButton.selected!) ? UIColor.black : UIColor.gray
        tabBarButton.iconImageView.image = UIImage(named: unSelectImageName)
        tabBarButton.iconImageView.highlightedImage = UIImage(named: selectImageName)
        
        return tabBarButton
    }

    // MARK: Event Handler
    // button被點擊事件
    @IBAction func mainTabBarButtonPressed(_ sender: UIButton) {
        self.delegate?.mainTabBarButtonPressedWith(mainTabBarButton: self)
    }

}
