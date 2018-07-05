//
//  ViewController.swift
//  ManageMoney
//
//  Created by admin101 on 4/2/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import TTSegmentedControl

class ViewController: UIViewController {
    

    //let segmentedControl = TTSegmentedControl()
   
    @IBOutlet weak var segment: TabySegmentedControl!
    
    @IBOutlet weak var tabSegment: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "daily"
        
        
    }
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
    }

   
}

