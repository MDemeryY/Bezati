//
//  ItemDetailsViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/9/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import DropDown

class ItemDetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var itemNameTxtField: UITextField!
    
    @IBOutlet weak var priceTxtField: UITextField!
    
    @IBOutlet weak var notesTxtField: UITextField!
    
    @IBOutlet weak var expenceButton: UIButton!
    
    @IBOutlet weak var incomeButton: UIButton!
    
    var badgetValues = ["USD" , "EUR" , "UK" , "SAR" , "RUK" , "GER"]
    
    var itemDetails:ItemData?
    
    //////////////////////////////////
    var inComeArray: [String] = []
    var outComeArray: [String] = []
    
    let dropDownIncome  = DropDown()
    let dropDownOutCome  = DropDown()
    
    var badgetInCome :Int = 1
    var badgetOutCome :Int = 1
    //////////////////////////////////
    
    var outComeCats:Category?
    var inComeCats:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemNameTxtField.text = itemDetails?.name!
        self.priceTxtField.text = "\(itemDetails!.price!)"
        self.notesTxtField.text = "\(itemDetails?.notes ?? "")"
        print("itemText : \(priceTxtField.text!)")
        self.incomeButton.setTitle(itemDetails?.incomeCategoryName, for: .normal)
        self.expenceButton.setTitle(itemDetails?.outComeCategoryName, for: .normal)
        priceTxtField.keyboardType = .numberPad
        FillIncomeArray()
        FillOutComeArray()
        
        
        //        badgetInCome = getIndex(current: itemDetails!, cats: (inComeCats?.data)!)
        
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func getBudgetIncomeIndex(current:ItemData , cats:[CategoryData]) -> Int{
        //        var counter = 0
        for item in 0..<cats.count {
            //            counter += 1
            if current.incomeCategoryName == cats[item].name{
                return item
            }
        }
        return 0
    }
    
    func getBudgetOutIncomeIndex(current:ItemData , cats:[CategoryData]) -> Int{
        //        var counter = 0
        for item in 0..<cats.count {
            //            counter += 1
            if current.outComeCategoryName == cats[item].name{
                return item
            }
        }
        return 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func expenceBtnAction(_ sender: UIButton) {
        
        dropBadgetMenuOutcome()
        dropDownOutCome.show()
        
    }
    
    
    @IBAction func incomeBtnAction(_ sender: UIButton) {
        dropBadgetMenuIncome()
        dropDownIncome.show()
    }
    
    @IBAction func updateItemAction(_ sender: UIButton) {
        
        print("Updated Button")
        
        let productPrice  = Language().setNumberFormater(language: "EN", number: self.priceTxtField.text!)
        
        if (priceTxtField.text?.isEmpty)! || (itemNameTxtField.text?.isEmpty )!{
            if Language.currentLanguage() == "en"{
                alert(message: "All fields are required!", title: "Error!")
            }else{
                alert(message: "جميع الحقول مطلوبة!", title: "خطأ!")
                
            }
        }
        if Language.currentLanguage() == "en" {
            self.showHud("Loading...")
        }else{
            self.showHud("جار التحميل...")
        }
        AllRequset().insertItems(Id: (itemDetails?.id)! , Name: itemNameTxtField.text!, Notes: notesTxtField.text!,
                                 Price: Double(productPrice), IncomeCategoryId: (self.inComeCats?.data?[badgetInCome].id)!
            ,
                                 OutComeCategoryId:  (self.outComeCats?.data![badgetOutCome].id)!,
                                 
                                 accessToken: HandleToken.token, success: { (success) in
                                    self.hideHUD()
                                    if success.code > 0{
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
                                        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! Home
                                        self.navigationController?.pushViewController(resultViewController, animated: true)
                                    }else{
                                        if Language.currentLanguage() == "en" {
                                            self.alert(message: "Error to save the item , please try again!", title: "Error!")
                                        }else{
                                            self.alert(message: "حدث خطأ في حفظ العنصر ، يرجى المحاولة مرة أخرى!", title: "خطأ!")
                                        }
                                        
                                    }
        }, error: { (error) in
            //self.hideHUD()
            if Language.currentLanguage() == "en" {
                self.alert(message: error+" , please try again!", title: "Error!")
            }else{
                self.alert(message: error+"حاول مرة اخرى!", title: "خطأ!")
            }
        })
    }
    
    @IBAction func deleteItemAction(_ sender: UIButton) {
        
        var okActionTitle = "OK"
        var cancelActionTitle = "Cancel"
        
        if Language.currentLanguage() != "en"{
            okActionTitle = "نعم"
            cancelActionTitle = "إلغاء"
        }
        
        
        var  alertController = UIAlertController(title: "Warning!", message: "Are you sure want to delete this item ?", preferredStyle: .alert)
        
        if Language.currentLanguage() != "en" {
            alertController = UIAlertController(title: "تحذير!", message: "هل أنت متأكد من حذف هذا البند؟", preferredStyle: .alert)
        }
        
        // Create the actions
        let okAction = UIAlertAction(title: okActionTitle, style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            AllRequset().deleteItem(id: (self.itemDetails?.id)!,accessToken: HandleToken.token , completion: { (result) in
                
                print(result)
                
                if result == 200 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
                    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! Home
                    self.navigationController?.pushViewController(resultViewController, animated: true)
                }
                else{
                    if Language.currentLanguage() == "en"{
                        self.alert(message: "Error in deleting this item , please try again!", title: "Error!")
                    }else{
                        self.alert(message: "خطأ في حذف هذا العنصر ، يرجى المحاولة مرة أخرى!", title: "خطأ!")
                    }
                    
                }
            })
            NSLog("OK Pressed")
        }
        
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func FillOutComeArray(){
        self.outComeArray.removeAll()
        AllRequset().CategoriesOutCome(accesToken: HandleToken.token) { (category) in
            self.outComeCats = category
            self.badgetOutCome = self.getBudgetOutIncomeIndex(current: self.itemDetails!, cats: category.data!)
            for item in category.data!
            {
                if !(self.outComeArray.count == category.data!.count){
                    self.outComeArray.append(item.name!)
                }
            }
        }
    }
    
    func FillIncomeArray(){
        self.inComeArray.removeAll()
        AllRequset().CategoriesInCome(accesToken: HandleToken.token) { (category) in
            self.inComeCats = category
            self.badgetInCome = self.getBudgetIncomeIndex(current: self.itemDetails!, cats: category.data!)
            
            for item in category.data!
            {
                if !(self.inComeArray.count == category.data!.count){
                    self.inComeArray.append(item.name!)
                }
            }
        }
    }
    
    func  dropBadgetMenuIncome() {
        dropDownIncome.anchorView = incomeButton
        dropDownIncome.bottomOffset = CGPoint(x: 0, y: incomeButton.bounds.height)
        dropDownIncome.dataSource = self.inComeArray
        dropDownIncome.selectionAction = { [weak self] (index, item) in
            self?.incomeButton.setTitle(item, for: .normal)
            self?.badgetInCome = index
        }
    }
    
    
    func  dropBadgetMenuOutcome() {
        dropDownOutCome.anchorView = expenceButton
        dropDownOutCome.bottomOffset = CGPoint(x: 0, y: expenceButton.bounds.height)
        dropDownOutCome.dataSource = self.outComeArray
        dropDownOutCome.selectionAction = { [weak self] (index, item) in
            self?.expenceButton.setTitle(item, for: .normal)
            self?.badgetOutCome = index
        }
    }
}
