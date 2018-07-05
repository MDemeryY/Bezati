//
//  RegisterVC.swift
//  Money Management
//
//  Created by Eng Nour Hegazy on 3/17/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import DropDown
class RegisterVC: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var startDayOFWaek: UIButton!
    @IBOutlet weak var currency: UIButton!
    @IBOutlet weak var emailLine: UIView!
    @IBOutlet weak var passwordLine: UIView!
    
    var allrequest = AllRequset()
    let dropDownWeak  = DropDown()
    let dropDownCurrency   = DropDown()
    var concurencyArr = [Concuranceys]()
    var concurencyId = 2 // from Services
    var accsessToken = String()
    var message = String()
    var dailyAlert = false
    var badgetSelected = false
    var  beginDayWeak :Int = 3 // From my Data
    var badgetValue = 3
    
    var weakDays = ["Sunday","Monday","Tuesday","Wensday","Thursday","Friday","Saterday"]
    
    
    
    
    @IBOutlet weak var nameline: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allrequest.getConcurrency {  ConcuranceysArr in
            self.concurencyArr = ConcuranceysArr
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func startDayOfWeakBtn(_ sender: Any) {
        drop()
        dropDownWeak.show()
    }
    
    @IBAction func currencyBtn(_ sender: Any) {
        
        var stringArr = concurencyArr.map { $0.name }
        
        self.dropDownCurrency.anchorView = currency
        dropDownCurrency.bottomOffset = CGPoint(x: 0, y: startDayOFWaek.bounds.height)
        dropDownCurrency.dataSource = stringArr as! [String]
        dropDownCurrency.selectionAction = { [weak self] (index, item) in
            self?.currency.setTitle(item, for: .normal)
            self?.concurencyId = index
        }
        dropDownCurrency.show()
        print(self.concurencyId)
    }
    
    
    @IBAction func registration(_ sender: Any) {
        
        if email.text! == "" || password.text! == "" || name.text! == "" {
            
            self.alertWithAction(message: "Please Enter impty Field  ")
        }
        else{
            allrequest.register(email: email.text!, name: name.text!, password: password.text!, concurencyId: concurencyId, dailyAlert: dailyAlert, badgetSelected: badgetSelected, beginDayWeak: beginDayWeak, badgetValue: badgetValue) {
                register in
                let   register = register
                self.accsessToken =   (register.accessToken)!
                self.message = register.requestDetails
                print("Message is  \(self.message)")
                if  self.message == "create account success" {
                    let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as!HomeVC
                    homeVc.accsessToken = self.accsessToken
                    self.navigationController?.pushViewController(homeVc, animated: true)
                    
                }else {self.alert(message: self.message)}
                
            }
            
        }
        
    }
    
    func  drop() {
        self.dropDownWeak.anchorView = startDayOFWaek
        dropDownWeak.bottomOffset = CGPoint(x: 0, y: startDayOFWaek.bounds.height)
        dropDownWeak.dataSource = weakDays
        dropDownWeak.selectionAction = { [weak self] (index, item) in
            self?.startDayOFWaek.setTitle(item, for: .normal)
        }
    }
    
    
}
