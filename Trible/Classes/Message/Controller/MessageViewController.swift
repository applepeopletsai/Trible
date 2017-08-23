//
//  MessageViewController.swift
//  Trible
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Event Handler
    // 我是探險家
    @IBAction func exploreMessageButtonPress(_ sender: UIButton) {
        let vc = StoryBoardTool.getViewControllerWith(storyBoardName: MESSAGE, viewControllerName: String(describing:MessageListViewController.self)) as! MessageListViewController
        vc.navigationTitle = "我是探險家"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 我是分享家
    @IBAction func shareMessageButtonPress(_ sender: UIButton) {
        let vc = StoryBoardTool.getViewControllerWith(storyBoardName: MESSAGE, viewControllerName: String(describing:MessageListViewController.self)) as! MessageListViewController
        vc.navigationTitle = "我是分享家"
        navigationController?.pushViewController(vc, animated: true)
    }

}
