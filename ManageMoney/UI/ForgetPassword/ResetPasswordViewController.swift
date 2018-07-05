//
//  ResetPasswordViewController.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 5/27/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var codeTxtField: UITextField!
    
    @IBOutlet weak var newPasswordTxtField: UITextField!
    
    
    @IBOutlet weak var resetPassword: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIHelper().assignbackground(backgroundName: "background", view: self.view)
        
        makeRadiosView(view: emailTxtField, radios: 15)
        makeRadiosView(view: codeTxtField, radios: 15)
        makeRadiosView(view: newPasswordTxtField, radios: 15)
        makeRadiosView(view: resetPassword, radios: 15)
        
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        codeTxtField.attributedPlaceholder = NSAttributedString(string: "Code",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        
        newPasswordTxtField.attributedPlaceholder = NSAttributedString(string: "New Password",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        emailTxtField.layer.masksToBounds = true
        emailTxtField.layer.borderColor = UIColor.white.cgColor
        emailTxtField.layer.borderWidth = 1.0
        
        codeTxtField.layer.masksToBounds = true
        codeTxtField.layer.borderColor = UIColor.white.cgColor
        codeTxtField.layer.borderWidth = 1.0
        
        newPasswordTxtField.layer.masksToBounds = true
        newPasswordTxtField.layer.borderColor = UIColor.white.cgColor
        newPasswordTxtField.layer.borderWidth = 1.0
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if let image = UIImage(named: "arabicBack.png") {
            backButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func resetPasswordActionButton(_ sender: UIButton) {
        if (emailTxtField.text?.isEmpty)! || (newPasswordTxtField.text?.isEmpty)! || (codeTxtField.text?.isEmpty)! {
            self.alert(message: "Error!", title: "Please all Fileds are required!")
        }else{
            if Language.currentLanguage() == "en" {
                self.showHud("Loading...")
            }else{
                self.showHud("جار التحميل...")
            }
            AllRequset().resetPassword(email: emailTxtField.text!, newPassword: newPasswordTxtField.text!, code: Int(codeTxtField.text!)!) { (result) in
                self.hideHUD()
                if result.code == 1 {
                    self.alert(message: result.message, title: "Success!")
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }else{
                    self.alert(message: result.message, title: "Error!")
                }
                
            }
        }
        
        
    }
}
