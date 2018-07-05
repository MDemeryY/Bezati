//
//  TestingFloatyViewController.swift
//  Money Management
//
//  Created by Ahmed Fadl on 3/31/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import Floaty
import TTSegmentedControl


class TestingFloatyViewController: UIViewController {

    let floaty = Floaty()
    let segmentedControl = TTSegmentedControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        floaty.addItem("Add New Item", icon: UIImage(named: "plus")!, handler: { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        
        segmentedControl.allowChangeThumbWidth = false
        segmentedControl.frame = CGRect(x: 50, y: 200, width: 100, height: 50)
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
        }
        
        view.addSubview(segmentedControl)
        
        self.view.addSubview(floaty)
        
    }
    

}
