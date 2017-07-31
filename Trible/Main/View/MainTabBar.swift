//
//  MainTabBar.swift
//  Trible
//
//  Created by Daniel on 2017/7/9.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

protocol MainTabBarDelegate: class {
    func mainTabBarDidSelectWith(index:Int)
}

class MainTabBar: UIView, MainTabBarButtonDelegate {

    // MARK: Property
    weak var delegate:MainTabBarDelegate?
    
    var selectedTabBarButton:MainTabBarButton?
    var tabBarButtonArray:[MainTabBarButton]?
    
    /* 點選的Index */
    var _selectIndex:Int?
    var selectIndex:Int? {
        get {
            return _selectIndex
        }
        set {
            _selectIndex = newValue
            
            let subviews = self.subviews as NSArray
            subviews.enumerateObjects({ (object, idx, stop) in
                
                if object is MainTabBarButton && (object as! MainTabBarButton).tag == _selectIndex {
                    self.setupSelectedTabBarButtonWith(mainTabBarButton: object as! MainTabBarButton)
                }
            })
        }
    }
    
    // MARK: Initailize
    // 初始化TabBar
    static func initWith(frame:CGRect, tabBarButtonArray:[MainTabBarButton]) -> MainTabBar {
        let tabBar = MainTabBar()
        tabBar.frame = frame
        tabBar.tabBarButtonArray = tabBarButtonArray
        tabBar.setupTabBarButtons()
        return tabBar
    }
    
    // 設置Tabbar的Buttons
    func setupTabBarButtons() {
        for i in (0..<(self.tabBarButtonArray?.count)!) {
            let width = self.frame.size.width / CGFloat((self.tabBarButtonArray?.count)!)
            let height = self.frame.size.height
            let x = width * CGFloat(i)
            let y:CGFloat = 0
            
            let frame = CGRect(x: x, y: y, width: width, height: height)
            
            let tabBarButton = (self.tabBarButtonArray?[i])!
            tabBarButton.frame = frame
            tabBarButton.tag = i
            tabBarButton.delegate = self
            self.addSubview(tabBarButton)
        }
    }
    
    
    // MARK: MainTabBarButtonDelegate
    // tabBar Button被點擊時呼叫
    func mainTabBarButtonPressedWith(mainTabBarButton: MainTabBarButton) {
        self.setupSelectedTabBarButtonWith(mainTabBarButton: mainTabBarButton)
    }
    
    // MARK: Class Method
    // 當所選取Button及SelectedIndex屬性被改變時呼叫
    func setupSelectedTabBarButtonWith(mainTabBarButton: MainTabBarButton) {
        if (self.selectedTabBarButton != nil) {
            self.selectedTabBarButton?.selected = false
        }
        
        mainTabBarButton.selected = true
        self.selectedTabBarButton = mainTabBarButton
        
        self.delegate?.mainTabBarDidSelectWith(index: mainTabBarButton.tag)
    }


}
