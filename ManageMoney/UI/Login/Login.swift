//
//  ViewController.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-01.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
//import Alamofire

class Login: BaseViewController,UITextFieldDelegate {
    var  allrequset = AllRequset()
    var accsessToken = ""
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailLine: UIView!
        @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordLine: UIView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var forgetBTN: UIButton!
    
    @IBOutlet weak var signupBTN: UIButton!
    override func viewDidAppear(_ animated: Bool) {
        
        if CheckTokenUserDefault(){
            print("success")
            self.performSegue(withIdentifier: "WelcomeHome", sender: nil)
            
        }
        else{
            print("failure")
        }
    }
 
    
    let forgetAttr : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20),
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    let signupAttr : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20),
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Language.currentLanguage() == "en" {
            let attributeString = NSMutableAttributedString(string: "Forget Password",
                                                            attributes: forgetAttr)
            
            let attributeStr = NSMutableAttributedString(string: "Sign Up",
                                                         attributes: signupAttr)
            forgetBTN.setAttributedTitle(attributeString, for: .normal)
            signupBTN.setAttributedTitle(attributeStr, for: .normal)

            
        }else{
            
            email.attributedPlaceholder =
                NSAttributedString(string: "البريد الالكتروني", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            password.attributedPlaceholder =
                NSAttributedString(string:"كلمة المرور", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
            
            let attributeString = NSMutableAttributedString(string: "نسيت كلمة المرور ؟",
                                                            attributes: forgetAttr)
            
            let attributeStr = NSMutableAttributedString(string: "التسجيل",
                                                         attributes: signupAttr)
            forgetBTN.setAttributedTitle(attributeString, for: .normal)
            signupBTN.setAttributedTitle(attributeStr, for: .normal)
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.attributedPlaceholder = NSAttributedString(string: "Email",
                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        email.layer.masksToBounds = true
        email.layer.borderColor = UIColor.white.cgColor
        email.layer.borderWidth = 1.0

        
        password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        password.layer.masksToBounds = true
        password.layer.borderColor = UIColor.white.cgColor
        password.layer.borderWidth = 1.0

      

        self.hideKeyboardWhenTappedAround()
        makeRadiosView(view: email , radios: 10)
        makeRadiosView(view: password , radios: 10)
        makeRadiosView(view: loginBtn ,  radios: 10)
        email.delegate = self
        password.delegate = self
        UIHelper().assignbackground(backgroundName: "background", view: self.view)
    }
    
    func CheckTokenUserDefault()-> Bool
    {
        let def = UserDefaults.standard
        let token = def.object(forKey: "AccessToken")
        
        if (token != nil)
        {
            return true
            
        }
        return false
    }
    
    
    func checkAuth(check: String){
        if check == "success"{
            self.performSegue(withIdentifier: "WelcomeHome", sender: nil)            
        }else
        {
            let alert = UIAlertController(title: "Error!" , message: "Please Check You Email or your Password!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if email.text!.isEmpty || password.text!.isEmpty {
            
            self.alertWithAction(message: "Please fill empty fields")
        }
        else {
            self.showHud("Loading")
            allrequset.login(email: email.text!, password: password.text!, completion: { (user) in
                if user.accessToken != "" {
                    self.accsessToken = user.accessToken!
                    //UserDefaults.standard.set(self.accsessToken, forKey: "AccessToken")
                    HandleToken.setToken(token: self.accsessToken)
                    self.checkAuth(check: "success")
                }
                else{
                    self.checkAuth(check: "failure")
                }
                self.hideHUD()
            })
        }
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if email.isEditing == true   {
//            self.emailLine.layer.backgroundColor = #colorLiteral(red: 0.3555280566, green: 0.784229815, blue: 0.865256846, alpha: 1)
//        }else {
//            if    email.text == "" {  self.emailLine.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)} }
//
//        if password.isEditing == true   {
//            self.passwordLine.layer.backgroundColor = #colorLiteral(red: 0.3555280566, green: 0.784229815, blue: 0.865256846, alpha: 1)
//        } else{
//            if password.text == "" {
//                self.passwordLine.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            }
//        }
//
//    }
    
    
    @IBAction func creatNewAccount(_ sender: Any) {
      
      
    
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        
//        var storyBoard: UIStoryboard?
//
//        let language = localizationHelper.getLanguage()
//
//        if language == "ar-EG"
//        {
//            localizationHelper.setLanguage(code: "en")
//
//        }else{
//            localizationHelper.setLanguage(code: "ar-EG")
//
//        }
//
//        storyBoard = UIStoryboard(name: "Login", bundle: nil)
//        let viewController = storyBoard?.instantiateViewController(withIdentifier: "Login")
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = viewController
        
//        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "Login")
//        self.present(secondViewController, animated: true, completion: nil)
//
    }
}



