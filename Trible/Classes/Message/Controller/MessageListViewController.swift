//
//  MessageListViewController.swift
//  Trible
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class MessageListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    var navigationTitle: String?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    //MARK: Initialize
    func setupNavigationBar() {
        setupNavigationBackButton(image: nil)
        navigationItem.title = navigationTitle
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:MessageListCell.self), for: indexPath) as! MessageListCell
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryBoardTool.getViewControllerWith(storyBoardName: MESSAGE, viewControllerName: String(describing:MessageContentViewController.self)) as! MessageContentViewController
        vc.navigationTitle = "title"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
