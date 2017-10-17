//
//  LoginViewController.swift
//  Trible
//
//  Created by Daniel on 2017/9/12.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit
import SwiftyJSON
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func fbLoginButtonPress(_ sender: UIButton) {
        if (FBSDKAccessToken.current()) != nil {
            getFbProfile()
        } else {
            FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (ressult, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    return
                } else {
                    self.getFbProfile()
                }
            }
        }
    }
    
    @IBAction func googleLoginButtonPress(_ sender: UIButton) {
       GIDSignIn.sharedInstance().signIn()
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
                    if let userName = dataDic["email"] as? String, let providerKey = dataDic["id"] as? String {
                        print(userName)
                        print(providerKey)
                        APIManager.apiLogin(userName: userName, password: "", providerKey: providerKey, loginProvider: "Facebook", handler: { response in
                            if response.result.isSuccess {
                                if let data = response.data {
                                    let json = JSON(data)
                                    if json["StatusCode"].intValue == 200 {
                                        // 如果成功，代表已經在網站上註冊過且已連結facebook
                                        // 導到首頁
                                         let vc = StoryBoardTool.getTabBarControllerWith(storyBoardName: MAIN, viewControllerName: String(describing: MainTabBarController.self))
                                        self.present(vc, animated: true, completion: nil)
                                    } else {
                                        // 如果失敗，代表沒有在網站上註冊過
                                        // Create
                                        
                                    }
                                    print(JSON(data))
                                }
                            } else {
                                print(response.error?.localizedDescription ?? "")
                            }
                        })
                    }
                }
            }
        })
    }
}

// MARK: Google Delegate
extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            APIManager.apiLogin(userName: user.profile.email, password: "", providerKey: user.userID, loginProvider: "Google", handler: { response in
                if response.result.isSuccess {
                    if let data = response.data {
                        let json = JSON(data)
                        print(json)
                        if json["StatusCode"].intValue == 200 {
                            // 如果成功，代表已經在網站上註冊過且已連結google
                            // 導到首頁
                            let vc = StoryBoardTool.getTabBarControllerWith(storyBoardName: MAIN, viewControllerName: String(describing: MainTabBarController.self))
                            self.present(vc, animated: true, completion: nil)
                        } else {
                            // 如果失敗，代表沒有在網站上註冊過
                            // Create
                            
                        }
                    }
                } else {
                    
                }
            })
//            print("user: \(user)")
//            print("userId: \(user.userID)")
//            print("accessToken: \(user.authentication.accessToken)")
//            print("clientID: \(user.authentication.clientID)")
//            print("idToken: \(user.authentication.idToken)")
//            print("name: \(user.profile.name)")
//            print("givenName: \(user.profile.givenName)")
//            print("familyName: \(user.profile.familyName)")
//            print("email: \(user.profile.email)")
        } else {
            print("Google登入失敗 : \(error.localizedDescription)")
        }
    }
}

extension LoginViewController: GIDSignInUIDelegate {
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}
