//
//  ItemPickerViewController.swift
//  Trible
//
//  Created by Daniel on 2017/8/1.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

protocol ItemPickerViewControllerDelegate:class {
    func didSelectItemWith(row:Int)
}

class ItemPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    
    weak var delegate:ItemPickerViewControllerDelegate?
    let toolBarHeight:CGFloat = 44.0
    var dataArray:NSArray = []
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupMaskButton()
    }
    
    // MARK: Initialize
    func setupItemPickerViewWith(dataArray:NSArray) {
        self.dataArray = dataArray
    }
    
    func setupPickerView() {
        // 先將pickerView移至畫面外
        pickerViewBottomConstraint.constant = -(pickerView.frame.size.height + toolBarHeight)
        view.layoutIfNeeded()
    }
    
    func setupMaskButton() {
        maskButton.alpha = 0.0
    }
    
    // MARK: UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    // MARK: UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        if dataArray.count != 0 {
            title = dataArray[row] as! String
        }
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 38.0
    }
    
    // MARK: Event Handler
    @IBAction func maskButtonPress(_ sender: UIButton) {
        slideDownWithAnimation()
    }
    
    @IBAction func finishButtonPress(_ sender: UIButton) {
        delegate?.didSelectItemWith(row: pickerView.selectedRow(inComponent: 0))
        slideDownWithAnimation()
    }
    
    // MARK: Class Method
    func setSelectRowWith(row:Int) {
        pickerView.selectRow(row, inComponent: 0, animated: true)
    }
    
    func slideUpWithAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { 
            self.pickerViewBottomConstraint.constant = 0.0
            self.maskButton.alpha = 1.0
            self.view.layoutIfNeeded()
        })
    }
    
    func slideDownWithAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { 
            self.pickerViewBottomConstraint.constant = -(self.pickerView.frame.size.height + self.toolBarHeight)
            self.maskButton.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.view.removeFromSuperview()
        })
    }
    
}


