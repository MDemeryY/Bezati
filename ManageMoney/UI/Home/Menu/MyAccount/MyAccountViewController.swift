//
//  MyAccountViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/6/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import DropDown
class MyAccountViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var currencyButton: UIButton!
    
    @IBOutlet weak var updateBTN: UIButton!
    let dropDownCurrency = DropDown()
    
    var concuranceyId :Int?
    
    var badgetValues = ["USD" , "EUR" , "UK" , "SAR" , "RUK" , "GER"]

    var accsessToken = UserDefaults.standard.object(forKey: "AccessToken") as! String

    
    override func viewDidLoad() {
        updateBTN.layer.cornerRadius = 10
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "My Account"

        if Language.currentLanguage() == "en" {
            self.navigationController?.navigationBar.topItem?.title = "My Account"
        }else{
            self.navigationController?.navigationBar.topItem?.title = "حسابي"
        }
        
        AllRequset().getUserInfo(accessToken: accsessToken) { (result) in
            self.concuranceyId = result.ConcuranceyId
            self.nameLabel.text = result.FullName
            self.emailLabel.text = result.Email
            self.currencyButton.setTitle(self.badgetValues[result.ConcuranceyId! - 1 ], for: .normal)
            
        }
    }
    
    @IBAction func currencyButtonAction(_ sender: UIButton) {
        dropBadgetMenu()
        dropDownCurrency.show()
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        
        self.showHud("Loading...")
        
        AllRequset().getUserInfo(accessToken: HandleToken.token) { (userInfo) in
            
            AllRequset().updateUserInfo(Email: self.emailLabel.text!, FullName: self.nameLabel.text!, ConcuranceyId: self.concuranceyId! + 1, BadgetSelected: userInfo.BadgetSelected!, BadgetValue: userInfo.BadgetValue!, DailyAlert: userInfo.DailyAlert!, BegainDay: userInfo.BegainDay!, accessToken: self.accsessToken,success: { (success) in
                
                self.hideHUD()
            }, error: { (error) in
                
            })
            
        }
    }
    
    
    func  dropBadgetMenu() {
        dropDownCurrency.anchorView = currencyButton
        dropDownCurrency.bottomOffset = CGPoint(x: 0, y: currencyButton.bounds.height)
        dropDownCurrency.dataSource = badgetValues
        dropDownCurrency.selectionAction = { [weak self] (index, item) in
            //self?.c.setTitle(item, for: .normal)
            self?.currencyButton.setTitle(item, for: .normal)
            self?.concuranceyId = index
        }
    }
    
}
