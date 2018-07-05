//
//  PasswordVC.swift
//  ManageMoney
//
//  Created by admin101 on 4/7/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit

class PasswordVC: UIViewController {
  
    @IBOutlet weak var oldtext: UITextField!
    @IBOutlet weak var newText: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
    }

    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        if (oldtext.text?.isEmpty)! || (newText.text?.isEmpty)!{
            
        }
        
        AllRequset().resetPassword(newPassword: newText.text ?? "", oldPassword: oldtext.text!, accessToken:HandleToken.token ,success: { (success) in
            
            if success.code == 0{
                if Language.currentLanguage() == "en" {
                    self.alert(message: "Password Change Failed!", title: "Error!")
                }else{
                    self.alert(message: "فشل تغيير كلمة المرور!", title: "خطأ!")
                }
            }else{
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "passwordReset"), object: "Password Changed Successfully")
            }
            
        }) { (error) in
            if Language.currentLanguage() == "en" {
                self.alert(message: "Password Change Failed!", title: "Error!")
            }else{
                self.alert(message: "فشل تغيير كلمة المرور!", title: "خطأ!")
            }
        }
    }

    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
