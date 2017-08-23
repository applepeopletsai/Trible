//
//  ExploreSearchViewController.swift
//  Trible
//
//  Created by Daniel on 2017/8/6.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit

enum SelectType {
    case Price, Count, Country, City
}

let priceArray: NSArray =   ["1000以下","1000-2000","2000-3000","3000-4000"]
let countArray: NSArray =   ["1人","2人","3人","4人以上"]
let countryArray: NSArray = [""]
let cityArray: NSArray =    [""]

class ExploreSearchViewController: BaseViewController, ItemPickerViewControllerDelegate {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    var selectType: SelectType?
    
    // MARK: Lif Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: ItemPickerViewDelegate
    func didSelectItemWith(row: Int) {
        switch selectType! {
        case .Price:
            priceTextField.text = priceArray[row] as? String
            break
        case .Count:
            countTextField.text = countArray[row] as? String
            break
        case .Country:
            countryTextField.text = countryArray[row] as? String
            break
        case .City:
            cityTextField.text = cityArray[row] as? String
            break
        }
    }
    
    // MARK: Event Handler
    @IBAction func cancelButtonPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPriceButtonPress(_ sender: UIButton) {
        selectType = .Price
        setupItemPickerViewWith(viewConroller: self, dataArray: priceArray, selectRow: 0, target: self)
    }
    
    @IBAction func selectCountButtonPress(_ sender: UIButton) {
        selectType = .Count
        setupItemPickerViewWith(viewConroller: self, dataArray: countArray, selectRow: 0, target: self)
    }
    
    @IBAction func selectCountryButtonPress(_ sender: UIButton) {
        selectType = .Country
        setupItemPickerViewWith(viewConroller: self, dataArray: countryArray, selectRow: 0, target: self)
    }
    
    @IBAction func selectCityButtonPress(_ sender: UIButton) {
        selectType = .City
        setupItemPickerViewWith(viewConroller: self, dataArray: cityArray, selectRow: 0, target: self)
    }
    
    @IBAction func confirmButtonPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
