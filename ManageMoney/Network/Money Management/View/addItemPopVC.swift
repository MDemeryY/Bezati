//
//  addItemPopVC.swift
//  Money Management
//
//  Created by Eng Nour Hegazy on 3/27/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import DropDown
class addItemPopVC: UIViewController {
  let  allrequest  = AllRequset()
  @IBOutlet weak var itemName: UITextField!
  @IBOutlet weak var price: UITextField!
  @IBOutlet weak var note: UITextField!
  @IBOutlet weak var incomeBtn: UIButton!
  @IBOutlet weak var outComeBtn: UIButton!
  
    @IBAction func incomBTN(_ sender: Any) {
    }
    @IBAction func outComBTN(_ sender: Any) {
    }
  @IBAction func addBtn(_ sender: Any) {
//    allrequest.insertItems(Id: 0, Name: itemName.text!, Notes: note.text!, Price: Int(price.text!), IncomeCategoryId: <#T##Int#>, OutComeCategoryId: <#T##Int#>, accessToken: <#T##String#>, completion: <#T##((Int) -> Void)##((Int) -> Void)##(Int) -> Void#>)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    

  

}
