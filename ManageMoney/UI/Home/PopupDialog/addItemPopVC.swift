//
//  addItemPopVC.swift
//  Money Management
//
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import DropDown


class addItemPopVC: UIViewController {
    let  allrequest  = AllRequset()
    var inComeArray: [String] = []
    var outComeArray: [String] = []
    
    let dropDownIncome  = DropDown()
    let dropDownOutCome  = DropDown()
    
    var badgetInCome :Int = 1
    var badgetOutCome :Int = 1
    
    var outComeCats:Category?
    var inComeCats:Category?
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var incomeBtn: UIButton!
    @IBOutlet weak var outComeBtn: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var allRequests = AllRequset()
    
    @IBAction func incomBTN(_ sender: Any) {
        
        self.dropBadgetMenuIncome()
        self.dropDownIncome.show()
        
    }
    @IBAction func outComBTN(_ sender: Any) {
        self.dropBadgetMenuOutcome()
        self.dropDownOutCome.show()
    }
    @IBAction func addBtn(_ sender: Any) {
        
        
        print("add btn")
        
        if (itemName.text?.isEmpty)! || (price.text?.isEmpty)! {
            alert(message: "All Fields Are Required", title: "Error!")
        }else{
            let productPrice  = Language().setNumberFormater(language: "EN", number: self.price.text!)
            
            AllRequset().insertItems(Id: 0, Name: itemName.text!,
                                     Notes: note.text!,
                                     Price: Double(productPrice),
                                     IncomeCategoryId: (self.inComeCats?.data![badgetInCome].id)!,
                                     OutComeCategoryId: (self.outComeCats?.data![badgetOutCome].id)!,
                                     accessToken: HandleToken.token, success: { (success) in
                print(success.code)
                if success.code > 0{
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "itemAdded"), object:"added")
                    

                }else{
                    self.alert(message: "Error to save the item , please try again!", title: "Error!")
                }
                self.hideHUD()
            }, error: { (error) in
                self.alert(message: error+" , please try again!", title: "Error!")
                self.hideHUD()
            })
        }
        
    }
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addButton.layer.cornerRadius = 5
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor(red: 91 / 255, green: 200 / 255, blue: 221 / 255, alpha: 1).cgColor
        
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(red: 91 / 255, green: 200 / 255, blue: 221 / 255, alpha: 1).cgColor
        
        FillIncomeArray()
        FillOutComeArray()
        
        price.keyboardType = .decimalPad
    }
    
    func FillOutComeArray(){
        AllRequset().CategoriesOutCome(accesToken: HandleToken.token) { (category) in
            self.outComeCats = category
            
            for item in category.data!
            {
                if !(self.outComeArray.count == category.data!.count){
                    self.outComeArray.append(item.name!)
                }
            }
            
        }
    }
    
    func FillIncomeArray(){
        inComeArray.removeAll()
        AllRequset().CategoriesInCome(accesToken: HandleToken.token) { (category) in
            self.inComeCats = category
            for item in category.data!
            {
                if !(self.inComeArray.count == category.data!.count){
                    self.inComeArray.append(item.name!)
                }
                
            }
            
        }
    }
    
    func  dropBadgetMenuIncome() {
        dropDownIncome.anchorView = incomeBtn
        dropDownIncome.bottomOffset = CGPoint(x: 0, y: incomeBtn.bounds.height)
        dropDownIncome.dataSource = self.inComeArray
        dropDownIncome.selectionAction = { [weak self] (index, item) in
            self?.incomeBtn.setTitle(item, for: .normal)
            self?.badgetInCome = index
        }
    }
    
    
    func  dropBadgetMenuOutcome() {
        dropDownOutCome.anchorView = outComeBtn
        dropDownOutCome.bottomOffset = CGPoint(x: 0, y: outComeBtn.bounds.height)
        dropDownOutCome.dataSource = self.outComeArray
        dropDownOutCome.selectionAction = { [weak self] (index, item) in
            self?.outComeBtn.setTitle(item, for: .normal)
            self?.badgetOutCome = index
        }
    }
    
}
