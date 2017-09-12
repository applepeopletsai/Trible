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
            fetchProfile()
            APIManager.apiGetMember(key: FBSDKAccessToken.current().userID, handler: { response in
                if response.result.isSuccess {
                    
                    if let data = response.result.value {
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
                self.fetchProfile()
            }
        }
    }
    
    func fetchProfile() {
        print("attempt to fetch profile......")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large), name, link, birthday"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("登入失敗")
                print("longinerror =\(String(describing: error?.localizedDescription))")
            } else {
                
                if let resultNew = result as? [String:Any] {
                    
                    print("成功登入")
                    
                    let email = resultNew["email"]  as! String
                    print(email)
                    
                    let firstName = resultNew["first_name"] as! String
                    print(firstName)
                    
                    let lastName = resultNew["last_name"] as! String
                    print(lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url) //臉書大頭貼的url, 再放入imageView內秀出來
                    }
                }
            }
        })
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("登入Facebook")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("登出Facebook")
    }
    
}
