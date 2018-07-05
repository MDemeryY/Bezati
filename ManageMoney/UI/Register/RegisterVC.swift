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
    
    @IBOutlet weak var backBtnOutlet: UIToolbar!
    @IBOutlet weak var tabbar: UIToolbar!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var startDayOFWaek: UIButton!
    @IBOutlet weak var currency: UIButton!
    
    @IBOutlet weak var toolbarName: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    var allrequest = AllRequset()
    let dropDownWeak  = DropDown()
    let dropDownCurrency   = DropDown()
    var concurencyArr = [Concuranceys]()
    var concurencyId = 2 // from Services
    var accsessToken = String()
    var message = String()
    var dailyAlert = false
    var badgetSelected = false
    var beginDayWeak :Int = 6 // From my Data
    var badgetValue :Int = 0
    
    var weakDays = ["Sunday ","Monday ","Tuesday ","Wensday ","Thursday ","Friday ","Saturday"]
    var badgetValues = ["USD" , "EUR" , "UK" , "SAR" , "RUK" , "GER"]   
    
    @IBOutlet weak var nameline: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {

        if Language.currentLanguage() == "en" {
            
        }else{
            
            email.attributedPlaceholder =
                NSAttributedString(string: "البريد الالكتروني", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            password.attributedPlaceholder =
                NSAttributedString(string:"كلمة المرور", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            name.attributedPlaceholder =
                NSAttributedString(string:"الاسم", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
            if let image = UIImage(named: "arabicBack.png") {
                backButton.setImage(image, for: .normal)
            }
        }
        
//        UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
        self.hideKeyboardWhenTappedAround()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRadiosView(view: registerBtn, radios: 15)
        makeRadiosView(view: email, radios: 15)
        makeRadiosView(view: password, radios: 15)
        makeRadiosView(view: name, radios: 15)
        
        makeBorderForView(view: email)
        makeBorderForView(view: password)
        makeBorderForView(view: name)
        
        makeRadiosView(view: startDayOFWaek, radios: 15)
        makeRadiosView(view: currency, radios: 15)
        
        
        
        email.attributedPlaceholder = NSAttributedString(string: "Email",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        name.attributedPlaceholder = NSAttributedString(string: "Name",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        password.layer.masksToBounds = true
        password.layer.borderColor = UIColor.white.cgColor
        password.layer.borderWidth = 1.0
        
        email.layer.masksToBounds = true
        email.layer.borderColor = UIColor.white.cgColor
        email.layer.borderWidth = 1.0
        
        name.layer.masksToBounds = true
        name.layer.borderColor = UIColor.white.cgColor
        name.layer.borderWidth = 1.0
        
        currency.layer.masksToBounds = true
        currency.layer.borderColor = UIColor.white.cgColor
        currency.layer.borderWidth = 1.0
        
        startDayOFWaek.layer.masksToBounds = true
        startDayOFWaek.layer.borderColor = UIColor.white.cgColor
        startDayOFWaek.layer.borderWidth = 1.0
        
        UIHelper().assignbackground(backgroundName: "background", view: self.view)
        
        allrequest.getConcurrency {  ConcuranceysArr in
            self.concurencyArr = ConcuranceysArr
        }
        
    
        startDayOFWaek.setTitle("Saturday", for: .normal)
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func startDayOfWeakBtn(_ sender: Any) {
        dropWeekMenu()
        dropDownWeak.show()
    }
    
    @IBAction func currencyBtn(_ sender: Any) {
        dropBadgetMenu()
        dropDownCurrency.show()
    }
    
    
    @IBAction func registration(_ sender: Any) {
        
        print()
        
        if email.text!.isEmpty || password.text!.isEmpty || name.text!.isEmpty {
            if Language.currentLanguage() == "en"{
                self.alert(message: "Please Enter All Required Fields", title: "Error!")
            }else{
                self.alert(message: "الرجاء إدخال جميع الحقول المطلوبة", title: "خطأ!")
            }
            print("\(SwiftHelper().isValidEmail(testStr: email.text!))")
        }
        if SwiftHelper().isValidEmail(testStr: email.text!) == false{
            
            if Language.currentLanguage() == "en"{
                self.alert(message: "Please Enter A Valid Email", title: "Error!")
            }else{
                self.alert(message: "يرجى إدخال البريد الإلكتروني الصحيح", title: "خطأ!")
            }
        }
            
        else{
            
            print("begin Day Weak \(beginDayWeak)")
            print("Badget Value \(badgetValue)")
            showHud("Loading...")
        
            AllRequset().register(email: email.text!, name: name.text!, password: password.text!, concurencyId: badgetValue, dailyAlert: dailyAlert, badgetSelected: badgetSelected, beginDayWeak: beginDayWeak, badgetValue: 0 ,  completion: { (result) in
                
                
                if result.accessToken != "" {
                    //self.accsessToken = user.accessToken!
                    HandleToken.setToken(token: result.accessToken!)
                    print("Reg Access Token \(self.accsessToken)")
                    // self.checkReg(check: "success")
                    self.performSegue(withIdentifier: "goHome", sender: nil)
                    self.hideHUD()
                }
                else{
                    let alert = UIAlertController(title: "Error" , message: "Error to sign up please check your email or password and try again!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    self.hideHUD()
                }
                self.hideHUD()
            })
        }
    }
    
    func checkReg(check: String){
        if check == "success"{
            self.performSegue(withIdentifier: "goHome", sender: nil)
            print("Success")
            
        }else
        {
            print("failuer")
            
            let alert = UIAlertController(title: "Error in Registration" , message: "Please Try Again!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func  dropWeekMenu() {
        self.dropDownCurrency.anchorView = startDayOFWaek
        dropDownWeak.bottomOffset = CGPoint(x: 5, y:startDayOFWaek.bounds.height)
        
        dropDownWeak.dataSource = weakDays
        dropDownWeak.selectionAction = { [weak self] (index, item) in
            self?.startDayOFWaek.setTitle(item, for: .normal)
            self?.beginDayWeak = index
        }
    }
    
    func  dropBadgetMenu() {
        dropDownCurrency.anchorView = currency
        dropDownCurrency.bottomOffset = CGPoint(x: 0, y: currency.bounds.height)
        dropDownCurrency.dataSource = badgetValues
        dropDownCurrency.selectionAction = { [weak self] (index, item) in
            //self?.c.setTitle(item, for: .normal)
            self?.currency.setTitle(item, for: .normal)
            self?.badgetValue = index
        }
    }
}

