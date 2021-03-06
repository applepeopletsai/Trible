//
//  ExploreViewController.swift
//  Trible
//
//  Created by Daniel on 2017/7/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class ExploreViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let welcomeCell = tableView.dequeueReusableCell(withIdentifier: String(describing: WelcomeCell.self), for: indexPath) as! WelcomeCell
            return welcomeCell
        case 1:
            let recentBrowseCel = tableView.dequeueReusableCell(withIdentifier: String(describing: RecentBrowseCell.self), for: indexPath) as! RecentBrowseCell
            return recentBrowseCel
        case 2:
            let hotExperienceCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HotExperienceCell.self), for: indexPath) as! HotExperienceCell
            return hotExperienceCell
        case 3:
            let cityCategoryCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCategoryCell.self), for: indexPath) as! CityCategoryCell
            return cityCategoryCell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        
        switch indexPath.row {
        case 0: height = 100
        case 1: height = 0
        case 2: tableView.estimatedRowHeight = 300
                height = UITableViewAutomaticDimension
        case 3: tableView.estimatedRowHeight = 300
                height = UITableViewAutomaticDimension
        default: height = 0
        }
        
        return height
    }
    
}
