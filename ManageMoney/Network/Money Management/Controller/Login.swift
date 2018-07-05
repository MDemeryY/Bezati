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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
    }
    
    @IBAction func login(_ sender: Any) {
        if email.text!.isEmpty || password.text!.isEmpty {
            
            self.alertWithAction(message: "Enter user namer & Password ")
        }
        else {
            allrequset.login(email: email.text!, password: password.text!){
                
                login in
                let  login = login
                self.accsessToken =    login.accessToken!
                if (self.accsessToken != "" ){
                    UserDefaults.standard.set(self.accsessToken, forKey: "AccessToken")}
                print(self.accsessToken)
                self.alertWithAction(message: login.requestDetails)
                
            }
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as!HomeVC
            homeVc.accsessToken = self.accsessToken
            self.navigationController?.pushViewController(homeVc, animated: true)
            
            
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if email.isEditing == true   {
            self.emailLine.layer.backgroundColor = #colorLiteral(red: 0.3555280566, green: 0.784229815, blue: 0.865256846, alpha: 1)
        }else {
            if    email.text == "" {  self.emailLine.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)} }
        
        if password.isEditing == true   {
            self.passwordLine.layer.backgroundColor = #colorLiteral(red: 0.3555280566, green: 0.784229815, blue: 0.865256846, alpha: 1)
        } else{
            if password.text == "" {
                self.passwordLine.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }
        
    }
    
    @IBAction func creatNewAccount(_ sender: Any) {
        
        let registerVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterID") as! RegisterVC
        self.navigationController?.pushViewController(registerVc, animated: true)
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        let forgetVC =    self.storyboard?.instantiateViewController(withIdentifier: "ForgetID") as! ForgetPassword
        self.navigationController?.pushViewController(forgetVC, animated: true)
    }
    
}



