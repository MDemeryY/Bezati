//
//  MainViewController.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-01.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import Alamofire
class MainViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    var menuShowing = false
    var x : [Concuranceys] = []
    var y :LoginandRegister!
    var z : Concuranceys!
    var  allrequset = AllRequset()
    override func viewDidLoad() {
        super.viewDidLoad()
        leadingConstraint.constant = -250
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        
        
        //       allrequset.getConcurrency() {ConcuranceysArr in
        //         self.x = ConcuranceysArr
        //      print(self.x.count)}
        // Do any additional setup after loading the view.
        
        allrequset.register(email: "Eng.nour@gmail.com", name: "Nour", password: "123456", concurencyId: 4, dailyAlert: false, badgetSelected: false , beginDayWeak: 18, badgetValue: 500){ login
            in
            //   self.y = login
            //   print(self.y!.requestDetails)
        }
        //
        //    allrequset.login(email: "Eng.nour@googl.com", password: "nou20") { login in
        //
        //      self.y = login
        //      print(self.y.requestDetails)
        //    }
        
        allrequset.getConcurrencyWithId(id: 1) { (concuranceysId) in
            self.z = concuranceysId
            print(self.z.id)
        }
        
    }
    
    @IBAction func menuBTN(_ sender: Any) {
        
        //   print(result)
        if (menuShowing) {
            leadingConstraint.constant = -250
            UIView.animate(withDuration: 0.5, animations:{
                self.view.layoutIfNeeded()
            })
        }else{
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5, animations:{
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
        
    }
    
    
    
}
