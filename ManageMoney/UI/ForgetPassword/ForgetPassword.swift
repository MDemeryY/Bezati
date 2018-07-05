//
//  ForgetPassword.swift
//  Money Management
//
//  Created by Eng Nour Hegazy on 3/17/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit

class ForgetPassword: BaseViewController,UITextFieldDelegate {
    
  var allrequest = AllRequset()
  @IBOutlet weak var emailLine: UIView!
  @IBOutlet weak var emailForget: UITextField!
    
    @IBOutlet weak var toolbarName: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        if Language.currentLanguage() == "en" {
        }else{
            emailForget.attributedPlaceholder =
                NSAttributedString(string: "البريد الالكتروني", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            }
       
        if let image = UIImage(named: "arabicBack.png") {
            backButton.setImage(image, for: .normal)
        }
        self.hideKeyboardWhenTappedAround()
    }

  override func viewDidLoad() {
        super.viewDidLoad()
    makeRadiosView(view: emailForget , radios: 15)
        makeBorderForView(view: emailForget)
        makeRadiosView(view: sendBtn , radios: 15)
        UIHelper().assignbackground(backgroundName: "background", view: self.view)
    
        emailForget.attributedPlaceholder = NSAttributedString(string: "Email",
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    
        emailForget.layer.masksToBounds = true
        emailForget.layer.borderColor = UIColor.white.cgColor
        emailForget.layer.borderWidth = 1.0
    
    }
  
  @IBAction func backBtn(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
  }

  @IBAction func sendMail(_ sender: Any) {
    if Language.currentLanguage() == "en" {
        self.showHud("Loading...")
    }else{
        self.showHud("جار التحميل...")
    }
    allrequest.getPassWordG(email: self.emailForget.text!){
        
      emailStatus in
        self.hideHUD()
      let email = emailStatus
        if email.code == 1{
            self.performSegue(withIdentifier: "resetPassSegue", sender: self)
        }else{
            self.alertWithAction(message: email.message)
        }
    }
  }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //resetPassSegue
//        if segue.identifier == "resetPassSegue" {
//            if let vc = segue.destination as? ResetPasswordViewController {
//
//            }
//        }
//    }
}
