//
//  ExploreViewController.swift
//  Trible
//
//  Created by Daniel on 2017/7/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit
import SwiftyJSON

class ExploreViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, WelcomeCellDelegate {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let password = "a123456TribleIsAmazing"
//        
//        let data = password.data(using: String.Encoding.utf8)
//        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
//        CC_SHA256(((data! as NSData)).bytes, CC_LONG(data!.count), res?.mutableBytes.assumingMemoryBound(to: UInt8.self))
//        let passwordBase64 = res?.base64EncodedString(options: [])
//    
//        APIManager.apiLogin(userName: "member@123.com", password: passwordBase64!) { response in
//            if response.result.isSuccess {
//                
//                APIManager.apiGetMember(handler: { response1 in
//                    if response1.result.isSuccess {
//                        print(JSON(response1.result.value))
//                    } else {
//                        
//                    }
//                })
//                
//            } else {
//                
//            }
//        }
//        APIManager.apiGetCheckInfo(email: "apple@test.com") { response in
//            if response.result.isSuccess {
//                if let data = response.result.value {
//                    print(JSON(data))
//                }
//            } else {
//                
//            }
//        }
//        APIManager.apiGetExploreList { response in
//            if response.result.isSuccess {
//                if let data = response.result.value {
//                    print(JSON(data))
//                }
//            } else {
//                
//            }
//        }
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
        case 0: // 歡迎語/進入探險
            let welcomeCell = tableView.dequeueReusableCell(withIdentifier: String(describing: WelcomeCell.self), for: indexPath) as! WelcomeCell
            welcomeCell.delegate = self
            return welcomeCell
        case 1: // 最近瀏覽
            let recentBrowseCel = tableView.dequeueReusableCell(withIdentifier: String(describing: RecentBrowseCell.self), for: indexPath) as! RecentBrowseCell
            return recentBrowseCel
        case 2: // 熱門體驗
            let hotExperienceCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HotExperienceCell.self), for: indexPath) as! HotExperienceCell
            return hotExperienceCell
        case 3: // 城市分類
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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
 
    // MARK: WelcomeCellDelegate
    // 進入探險按鈕
    func exploreButtonPress() {
        let vc = StoryBoardTool.getViewControllerWith(storyBoardName: EXPLORE, viewControllerName: String(describing: ExploreListViewController.self)) as! ExploreListViewController
        _ = navigationController?.pushViewController(vc, animated: true)
    }
    
}
