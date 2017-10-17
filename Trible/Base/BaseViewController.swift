//
//  BaseViewController.swift
//  Trible
//
//  Created by Daniel on 2017/7/9.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

let rootViewController = UIViewController()
let SCREENWIDTH        = UIScreen.main.bounds.size.width
let SCREENHEIGHT       = UIScreen.main.bounds.size.height

let EXPLORE    = "Explore"
let MESSAGE    = "Message"
let BOOKING    = "Booking"
let EXPERIENCE = "Experiencer"
let MINE       = "Mine"
let SHARE      = "Share"
let MAIN       = "Main"

class BaseViewController: UIViewController {

    var itemPickerVC: ItemPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.barTintColor = UIColor.white
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
    
    func setupNavigationBackButton(image:UIImage?) {
//        self.navigationItem.hidesBackButton = true
        
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.setTitle("返回", for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backButton.setBackgroundImage(image, for: .normal)
        backButton.addTarget(self, action: #selector(navigationBackButtonPress), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setupNavigationLeftButton(image:UIImage?, title:String, target:Any, action:Selector) {
        let button = UIButton(type:.custom)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setupNavigationRightButton(image:UIImage?, title:String, target:Any, action:Selector) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func navigationBackButtonPress() {
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

    // MARK: ItemPickerViewController
    func setupItemPickerViewWith(viewConroller:UIViewController, dataArray:NSArray, selectRow:Int, target:Any) {
        self.view.endEditing(true)
        
        itemPickerVC = StoryBoardTool.getViewControllerWith(storyBoardName: SHARE, viewControllerName: String(describing:ItemPickerViewController.self)) as? ItemPickerViewController
        itemPickerVC?.delegate = target as? ItemPickerViewControllerDelegate
        itemPickerVC?.setupItemPickerViewWith(dataArray: dataArray)
        itemPickerVC?.view.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        
        viewConroller.view.window?.addSubview((itemPickerVC?.view)!)
        itemPickerVC?.setSelectRowWith(row: selectRow)
        itemPickerVC?.slideUpWithAnimation()
    }
    
    
}
