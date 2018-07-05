//
//  addItemPopVC.swift
//  Money Management
//
//  Created by Eng Nour Hegazy on 3/27/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import DropDown

class BudgetVc: UIViewController {

    @IBOutlet weak var newBudget: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var okBtn: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if Language.currentLanguage() != "en"{
            textView.text = "وضع الميزانية الشهرية كم تريد أن تنفق في الشهر"
        }
        self.hideKeyboardWhenTappedAround() 
    }

    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
//
//      AllRequset().updateUserInfo(Email: result.Email!, FullName: result.FullName!, ConcuranceyId: result.ConcuranceyId!, BadgetSelected: result.BadgetSelected!, BadgetValue: result.BadgetValue!, DailyAlert: result.DailyAlert!, BegainDay: result.BegainDay!, accessToken: accsessToken, completion:
//
    @IBAction func okButtonAction(_ sender: UIButton) {
        // bug 
        AllRequset().getUserInfo(accessToken: HandleToken.token) { (result) in
            AllRequset().updateUserInfo(Email: result.Email!, FullName: result.FullName!, ConcuranceyId: result.ConcuranceyId!, BadgetSelected: result.BadgetSelected!, BadgetValue: Int(self.newBudget.text!)!, DailyAlert: result.DailyAlert!, BegainDay: result.BegainDay!, accessToken: HandleToken.token, success: { (success) in
                if success.code == 0{
                    self.alert(message: success.message, title: "Error!")
                }else{
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: self.newBudget.text!)
                }
            }, error: { (error) in
                self.alert(message: error, title: "Error!")
            })
        }
    }
    
}
