//
//  APIManager.swift
//  Trible
//
//  Created by Daniel on 2017/8/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let API_URL = "http://triblewebapi.azurewebsites.net/"
let headers = ["X-Device-Type":"App"]

//\(UserDefaults().value(forKey: "token") as! String)
// A001 登入
let API_URL_LOGIN = API_URL + "Authentication/AppToken"

// MEM001 取得會員資料
let API_URL_MEMBER_GETINFO = API_URL + "Member/GetMemberByPatten"
// MEM002 一般註冊
let API_URL_MEMBER_CREATE = API_URL + "PostCreateMember"
// MEM003 檢查註冊帳號是否重複
let API_URL_MEMBER_CEHECKINFO = API_URL + "Member/CheckInfoByPatten"

// EXP001 取得體驗列表
let API_URL_GETLIST = API_URL + "Explore/GetExploreList"

class APIManager {
    
    // A001 登入，取得token
    // 一般登入帶Username及Password
    // Facebook與Google登入：取得userid後，帶入Username、ProviderKey、LoginProvider
    static func apiLogin(userName: String, password: String, providerKey: String, loginProvider: String, handler: @escaping (_ response: DataResponse<Any>) -> Void) {
        let parameters = ["Username":userName,
                          "Password":password,
                          "ProviderKey":providerKey,
                          "LoginProvider":loginProvider]
        
        request(API_URL_LOGIN, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            if let data = response.data {
                let json = JSON(data)
                if json["StatusCode"].intValue == 200 {
                    UserDefaults().set(json["Message"].stringValue, forKey: "token")
                    UserDefaults().synchronize()
                }
                handler(response)
            }
        }
    }
    
    // MEM001 取得會員資料
    static func apiGetMember(key: String, handler: @escaping (_ response: DataResponse<Any>) -> Void) {
        let url = API_URL_MEMBER_GETINFO + "/ProviderKey/" + key
        request(url, method: .get, headers:headers).responseJSON { response in
            handler(response)
        }
    }
    
    // MEM002 一般註冊
    static func apiPostCreateMember(email: String, password: String, confirmPassword: String, nickName: String, handler: @escaping (_ response: DataResponse<Any>) -> Void) {
        let parameters = ["RegisterEmail":email,
                          "RegisterPassword":password,
                          "RegisterConfirmPassword":confirmPassword,
                          "RegisterNickName":nickName]
        let header = ["X-Device-Type":"App"]
        request(API_URL_MEMBER_CREATE, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            handler(response)
        }
    }
    
    // MEM003 檢查註冊帳號是否重複
    static func apiGetCheckInfo(email: String, handler: @escaping (_ response: DataResponse<Any>) -> Void) {
        let url = API_URL_MEMBER_CEHECKINFO + "/\(1)/\(email)/"
        let header = ["X-Device-Type":"App"]
        request(url, method: .get, headers:header).responseJSON { response in
            handler(response)
        }
    }
    
    // EXP001 取得體驗列表
    static func apiGetExploreList(handler: @escaping (_ response: DataResponse<Any>)  -> Void) {
        request(API_URL_GETLIST, method: .get, headers: headers).responseJSON { response in
            handler(response)
        }
    }
    
    
}



