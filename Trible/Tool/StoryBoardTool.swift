//
//  StoryBoardTool.swift
//  Trible
//
//  Created by Daniel on 2017/7/9.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class StoryBoardTool: NSObject {
    static func getNavigationControllerWith(storyBoardName:String, navigationControllerName:String) -> UINavigationController {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: navigationControllerName) as! UINavigationController
    }
    
    static func getViewControllerWith(storyBoardName:String, viewControllerName:String) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: viewControllerName)
    }
}
