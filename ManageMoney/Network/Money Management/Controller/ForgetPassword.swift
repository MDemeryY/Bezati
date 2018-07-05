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
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  @IBAction func backBtn(_ sender: Any) {
    
    self.navigationController?.popViewController(animated: true)
  }

  @IBAction func sendMail(_ sender: Any) {
   
    allrequest.getPassWordG(email: self.emailForget.text!){
      emailStatus in
      let email = emailStatus
      self.alertWithAction(message: email.message)
      
    }
  }
  

}
