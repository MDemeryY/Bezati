//
//  AddCategoryIncome.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/11/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import DropDown

class AddCategoryIncome: UIViewController {

    @IBOutlet weak var incomeLabel: UITextField!
    
    @IBOutlet weak var priceValue: UITextField!
    
    @IBOutlet weak var incomeButton: UIButton!
    
    let dropDownOutCome  = DropDown()

    var inComeArray: [String] = []
    
    var badgetValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FillOutComeArray()
        self.hideKeyboardWhenTappedAround() 
        
    }
    
    var incomeDropArray = ["Food" , "Home" , "Personal" , "Salary" , "Saving" , "Shopping" , "Child" , "Car" , "Kast" , "Credit"]
    
    override func viewWillAppear(_ animated: Bool) {
        FillOutComeArray()
    }
    
    @IBAction func incomeButtonAction(_ sender: UIButton) {
        dropBadgetMenu()
        dropDownOutCome.show()
    }
    
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        if (incomeLabel.text?.isEmpty)! || (priceValue.text?.isEmpty)! {
            self.alert(message: "All fileds are required , please try again", title: "Error!")
        }else{
            AllRequset().insertCategoryIncome(id: 0, price: Double(priceValue.text!)!, name: incomeLabel.text!, icon: incomeDropArray[badgetValue], accessToken: HandleToken.token, completion: { (statusCode) in
                print(statusCode)
                if statusCode == 200{
                    self.dismiss(animated: true, completion: nil)
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "catIncomeAdded"), object:"added")
                }else{
                    self.alert(message: "Error to inserting a new category", title: "Error!")
                }
            })
        }
    }
    
    func FillOutComeArray(){
        AllRequset().CategoriesInCome(accesToken: HandleToken.token) { (category) in
            for item in category.data!
            {
                self.inComeArray.append(item.name!)
            }
        }
    }
    
    func  dropBadgetMenu() {
        dropDownOutCome.anchorView = incomeButton
        dropDownOutCome.bottomOffset = CGPoint(x: 0, y: incomeButton.bounds.height)
        dropDownOutCome.dataSource = self.incomeDropArray
        dropDownOutCome.selectionAction = { [weak self] (index, item) in
            self?.incomeButton.setTitle(item, for: .normal)
            self?.badgetValue = index
        }
    }
    
}
