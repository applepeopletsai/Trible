//
//  SystemManager.swift
//  Trible
//
//  Created by Daniel on 2017/10/5.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class SystemManager: NSObject {

    static let shared = SystemManager()
    
    var isKeyboardDidShow: Bool = false
    var isKeyboardDidHide: Bool = true
    var isKeyboardWillShow: Bool = false
    var isKeyboardWillHide: Bool = false
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardDidShow(notification:Notification) {
        self.isKeyboardDidShow = true
        self.isKeyboardDidHide = false
        self.isKeyboardWillShow = false
        self.isKeyboardWillHide = false
    }
    
    func keyboardDidHide(notification:Notification) {
        self.isKeyboardDidShow = false
        self.isKeyboardDidHide = true
        self.isKeyboardWillShow = false
        self.isKeyboardWillHide = false
    }
    
    func keyboardWillShow(notification:Notification) {
        self.isKeyboardDidShow = false
        self.isKeyboardDidHide = true
        self.isKeyboardWillShow = true
        self.isKeyboardWillHide = false
    }
    
    func keyboardWillHide(notification:Notification) {
        self.isKeyboardDidShow = true
        self.isKeyboardDidHide = false
        self.isKeyboardWillShow = false
        self.isKeyboardWillHide = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
