//
//  ExploreListViewController.swift
//  Trible
//
//  Created by Daniel on 2017/7/31.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class ExploreListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    //MARK: Initialize
    func setupNavigationBar() {
        setupNavigationBackButton(image: nil)
        setupNavigationRightButton(image: nil, title: "搜尋", target: self, action: #selector(searchButtonPress))
        navigationItem.title = "體驗列表"
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:ExploreListCell.self), for: indexPath) as! ExploreListCell
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight * 0.45
    }
    
    // MARK: Event Handler
    func searchButtonPress() {
        let vc = StoryBoardTool.getViewControllerWith(storyBoardName: explore, viewControllerName: String(describing:ExploreSearchViewController.self)) as! ExploreSearchViewController
        present(vc, animated: true, completion: nil)
    }
}
