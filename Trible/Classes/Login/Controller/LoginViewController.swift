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
                    for (key, value) in dataDic {
                        print("\(key): \(value)")
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
            print("user: \(user)")
            print("userId: \(user.userID)")
            print("accessToken: \(user.authentication.accessToken)")
            print("clientID: \(user.authentication.clientID)")
            print("idToken: \(user.authentication.idToken)")
            print("name: \(user.profile.name)")
            print("givenName: \(user.profile.givenName)")
            print("familyName: \(user.profile.familyName)")
            print("email: \(user.profile.email)")
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
