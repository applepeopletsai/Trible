//
//  MessageContentViewController.swift
//  Trible
//
//  Created by Daniel on 2017/8/15.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

class MessageContentViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    var navigationTitle: String?
    
    var changeLine:Bool = false
    var previousRect: CGRect = .zero
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNotificationObserver()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .bottom, animated: true)
    }
    
    //MARK: Initialize
    func setupNavigationBar() {
        setupNavigationBackButton(image: nil)
        navigationItem.title = navigationTitle
    }
    
    func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setupGestureRecognizer() {
        let gestureRecognizer:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:MessageInCell.self), for: indexPath) as! MessageInCell
        
        cell.contentLabel.text = "訊息內容 我是第\(indexPath.row)個 訊息內容 我是第\(indexPath.row)個 訊息內容 我是第\(indexPath.row)個 訊息內容 我是第\(indexPath.row)個"
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableViewAutomaticDimension
    }
    
    // MARK: UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if SystemManager.shared.isKeyboardWillShow {
            print("111")
        }
        
        if SystemManager.shared.isKeyboardDidShow {
            print("222")
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textViewHeight = (textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat(MAXFLOAT)))).height
        if textViewHeight > 80 {
            self.textView.isScrollEnabled = true
        } else {
            self.textView.isScrollEnabled = false
            
            UIView.animate(withDuration: 0.2, animations: { 
                self.bottomViewHeightConstraint.constant = textViewHeight
                
                // 讓訊息跟著textview移動
                if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.frame.size.height)) {
                    
                    let position = textView.endOfDocument;
                    let currentRect = textView.caretRect(for: position)
                    
                    // 給予previousRect初始值
                    if (self.previousRect == .zero) {
                        self.previousRect = currentRect
                    }
                    
                    // 大於0才是有效值
                    if currentRect.origin.y > 0 && self.previousRect.origin.y > 0 {
                        // 判斷如果當下輸入文字的位置(y值)如果大於上次輸入文字的位置(y值)，或者使用者按下return鍵時，代表換行
                        if currentRect.origin.y > self.previousRect.origin.y || self.changeLine {
                            let offSet = CGPoint(x: 0, y: self.tableView.contentOffset.y + (textView.font?.lineHeight)!)
                            self.tableView.setContentOffset(offSet, animated: false)
                        }
                    }
                    
                    // 自動換行時會小於0，為無效值，但還是要換行
                    if currentRect.origin.y < 0 {
                        let offSet = CGPoint(x: 0, y: self.tableView.contentOffset.y + (textView.font?.lineHeight)!)
                        self.tableView.setContentOffset(offSet, animated: false)
                    }
                    self.previousRect = currentRect
                }
            })
            self.view.layoutIfNeeded()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.changeLine = true
        } else {
            self.changeLine = false
        }
        return true
    }
    
    // MARK: Class Method
    func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomViewBottomConstraint.constant = keyboardSize.height
                if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.frame.size.height)) {
                    let offSet = CGPoint(x: 0, y: self.tableView.contentOffset.y + keyboardSize.height)
                    self.tableView.setContentOffset(offSet, animated: false)
                }
            })
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomViewBottomConstraint.constant = 0
        })
        self.view.layoutIfNeeded()
    }
}
