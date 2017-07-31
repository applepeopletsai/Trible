//
//  BaseViewController.swift
//  Trible
//
//  Created by Daniel on 2017/7/9.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let rootViewController = UIViewController()
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let sharer = "Sharer"
    let experience = "ExperienceViewCOntroller"
    let message = "MessageViewController"
    let reservation = "ReservationViewController"
    let personal = "PersonalViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: SetupNavigationStytle
    func setupNavigationTextFont(color:UIColor, font:UIFont) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:color, NSFontAttributeName:font]
    }
    
    func setupNavigationShadowImage(shadowImage:UIImage) {
        self.navigationController?.navigationBar.backIndicatorImage = shadowImage
    }
    
    func setupNavigationBackgroundImage(backgroundImage:UIImage) {
        self.navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
    }
    
    func setupNavigationBackgroundColor(color:UIColor) {
        self.navigationController?.view.backgroundColor = color
    }
    
    func setupNavigationBackButton(image:UIImage) {
        let backButton = UIButton(type: UIButtonType.custom) as UIButton
        backButton.frame = CGRect(x: 0, y: 0, width: 12, height: 20)
        backButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        backButton.setBackgroundImage(image, for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(navigationBackButton), for: UIControlEvents.touchUpInside)
//        self.navigationItem.hidesBackButton = true // 關閉navigation向右滑動回到上一頁功能
        let barButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setupNavigationLeftButton(image:UIImage, title:String, type:UIButtonType, target:Any, action:Selector) {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        let image = UIImage()
        button.frame = CGRect(x: 0, y: 0, width: 12, height: 20)
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button.setTitle(title, for: UIControlState.normal)
        button.setBackgroundImage(image, for: UIControlState.normal)
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setupNavigationRightButton(image:UIImage, title:String, type:UIButtonType, target:Any, action:Selector) {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        let image = UIImage()
        button.frame = CGRect(x: 0, y: 0, width: 12, height: 20)
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button.setTitle(title, for: UIControlState.normal)
        button.setBackgroundImage(image, for: UIControlState.normal)
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func navigationBackButton() {
        self.view.endEditing(true)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: StoryboardManager
    func getViewControllerWith(storyBoardName:String, viewControllerName:String) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: viewControllerName)
    }
    
    //MARK: AlertControllerManager
    func presentAlertControllerWith(alertTitle:String, alertMessage:String, confirmTitle:String, cancelTitle:String, target:Any, okActionHandler:((UIAlertAction) -> Void)?, cancelActionHandler:((UIAlertAction) -> Void)?) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default, handler: { (_) -> Void in
            if okActionHandler != nil {
                _ = okActionHandler
            }
        })
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (_) -> Void in
            if cancelActionHandler != nil {
                _ = cancelActionHandler
            }
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentErrorMessageWith(alertTitle:String, alertMessage:String, confirmTitle:String, target:Any, okActionHandler:((UIAlertAction) -> Void)?) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: confirmTitle, style: .default, handler: { (_) -> Void in
            if okActionHandler != nil {
                _ = okActionHandler
            }
        })
        
        alertController.addAction(okAction)
        
        _ = self.present(alertController, animated: true, completion: nil)
    }


}
