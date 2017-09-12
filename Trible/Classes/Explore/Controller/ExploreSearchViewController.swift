//
//  ExploreSearchViewController.swift
//  Trible
//
//  Created by Daniel on 2017/8/6.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import UIKit
import SwiftyJSON

enum SelectType {
    case price, count, country, city
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
        case .price:
            priceTextField.text = priceArray[row] as? String
            break
        case .count:
            countTextField.text = countArray[row] as? String
            break
        case .country:
            countryTextField.text = countryArray[row] as? String
            break
        case .city:
            cityTextField.text = cityArray[row] as? String
            break
        }
    }
    
    // MARK: Event Handler
    @IBAction func cancelButtonPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPriceButtonPress(_ sender: UIButton) {
        selectType = .price
        setupItemPickerViewWith(viewConroller: self, dataArray: priceArray, selectRow: 0, target: self)
    }
    
    @IBAction func selectCountButtonPress(_ sender: UIButton) {
        selectType = .count
        setupItemPickerViewWith(viewConroller: self, dataArray: countArray, selectRow: 0, target: self)
    }
    
    @IBAction func selectCountryButtonPress(_ sender: UIButton) {
        selectType = .country
        setupItemPickerViewWith(viewConroller: self, dataArray: countryArray, selectRow: 0, target: self)
    }
    
    @IBAction func selectCityButtonPress(_ sender: UIButton) {
        selectType = .city
        setupItemPickerViewWith(viewConroller: self, dataArray: cityArray, selectRow: 0, target: self)
    }
    
    @IBAction func confirmButtonPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
