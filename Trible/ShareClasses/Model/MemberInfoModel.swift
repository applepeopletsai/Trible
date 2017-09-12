//
//  MemberInfoModel.swift
//  Trible
//
//  Created by Daniel on 2017/8/31.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class MemberInfoModel: NSObject {
    var id:String?
    var password:String?
    var userName:String?
    var joinDate:String?
    var lastLoginDate:String?
    var memberId:String?
    var email:String?
    var emailConfirmStatus:Bool?
    var emailConfirmCode:String?
    var phone:String?
    var phoneConfirmStatus:Bool?
    var phoneConfirmCode:String?
    var userConfirm:Bool?
    var fbLinkConfirmStatus:Bool?
    var googleLinkConfirmStatus:Bool?
}
