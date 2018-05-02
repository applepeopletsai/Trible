//
//  MainTabBarController.swift
//  Trible
//
//  Created by Daniel on 2017/7/9.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, MainTabBarDelegate {
    
    // MARK: Prorerty
    var maintabBar: MainTabBar?
    var tabBarButtonArray: [MainTabBarButton]?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainTabBarController()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        for view in self.tabBar.subviews {
//            if view is MainTabBarButton {
//                view.removeFromSuperview()
//            }
//        }
    }
    
    // MARK: UI Setup
    /* 初始化tabBarItems */
    func setupMainTabBarController () {
        self.tabBarButtonArray = [MainTabBarButton.initWith(title: "探險",
                                                            unSelectImageName: "",
                                                            selectImageName: ""),
                                  MainTabBarButton.initWith(title: "訊息",
                                                            unSelectImageName: "",
                                                            selectImageName: ""),
                                  MainTabBarButton.initWith(title: "預訂",
                                                            unSelectImageName: "",
                                                            selectImageName: ""),
                                  MainTabBarButton.initWith(title: "體驗",
                                                            unSelectImageName: "",
                                                            selectImageName: ""),
                                  MainTabBarButton.initWith(title: "我的",
                                                            unSelectImageName: "",
                                                            selectImageName: "")]

        let exploreNav = StoryBoardTool.getNavigationControllerWith(storyBoardName: "Explore", navigationControllerName:"ExploreNav")
        let messageNav = StoryBoardTool.getNavigationControllerWith(storyBoardName:"Message", navigationControllerName:"MessageNav")
        let bookingNav = StoryBoardTool.getNavigationControllerWith(storyBoardName:"Booking", navigationControllerName:"BookingNav")
        let experienceNav = StoryBoardTool.getNavigationControllerWith(storyBoardName:"Experience", navigationControllerName:"ExperienceNav")
        let mineNav = StoryBoardTool.getNavigationControllerWith(storyBoardName:"Mine", navigationControllerName:"MineNav")
        self.viewControllers = [exploreNav,messageNav,bookingNav,experienceNav,mineNav]
        
        self.maintabBar = MainTabBar.initWith(frame: self.tabBar.bounds, tabBarButtonArray: self.tabBarButtonArray!)
        
        self.maintabBar?.selectIndex = self.selectedIndex
        self.maintabBar?.delegate = self
        
        self.tabBar.addSubview(self.maintabBar!)
        self.view.backgroundColor = UIColor.white
    }
    
    //MARK: MainTabBarDelegate
    // tabBar button被點擊時呼叫
    func mainTabBarDidSelectWith(index: Int) {
        // 改變TabBarController的selectedIndex屬性，為點擊button的index
        self.selectedIndex = index
    }
    
    // MARK: Class Method
//    func changeTabBarSelectIndexWith(index:Int) {
//        // 未按下button但須改變TabBarController的selectedIndex屬性
//        // 會呼叫BaseTabBar中的selectedIndex的setter方法
//        // 在selectedIndex的setter方法中會呼叫setupSelectedTabBarButton設置被選取的button
//        // 最後在selectedIndex的setter方法中呼叫didSelectBaseTabBarIndex改變TabBarController的selectedIndex屬性
//        self.maintabBar?.selectIndex = index
//    }
    
    
//    /* 清掉舊有的tabBar */
//    func removeTabBarFromSuperView() {
//        for (_,object) in self.tabBar.subviews.enumerated() {
//            if object is MainTabBar {
//                object.removeFromSuperview()
//            }
//        }
//    }


}
