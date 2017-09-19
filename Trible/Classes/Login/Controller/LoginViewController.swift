//
//  LoginViewController.swift
//  Trible
//
//  Created by Daniel on 2017/9/12.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON

class LoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fbLoginButtonPress(_ sender: UIButton) {
        if (FBSDKAccessToken.current()) != nil {
            getFbProfile()
            APIManager.apiGetMember(key: FBSDKAccessToken.current().userID, handler: { response in
                if response.result.isSuccess {
                    if let data = response.data {
                        print(JSON(data))
                    }
                    
                } else {
                    
                }
            })
        } else {
            FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (ressult, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    return
                }
                self.getFbProfile()
            }
        }
    }
    
    func getFbProfile() {
        
        // 需要取得的資訊種類
        let parameters = ["fields": "id, first_name, last_name, name, email, picture.type(large), link, birthday"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("FB Login Error : \(String(describing: error?.localizedDescription))")
            } else {
                print("FB登入成功")
                
                if let dataDic = result as? [String:Any] {
                    for (key, value) in dataDic {
                        print("\(key): \(value)")
                    }
                }
            }
        })
    }
}

