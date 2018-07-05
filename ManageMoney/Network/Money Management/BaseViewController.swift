//
//  BaseViewController.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-05.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit
import SystemConfiguration

class BaseViewController: UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func alertWithAction(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: {(alert :UIAlertAction!) in
            // handle your code here
            self.viewDidLoad()
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated:true);
        let backButton = UIBarButtonItem(image: UIImage(named:"back"),
                                         style: UIBarButtonItemStyle.plain ,
                                         target: self, action:#selector(backTapped))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - IBActions
    @objc func backTapped(button: UIButton)
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Check Internet Connection
    func isInternetAvailable() -> Bool
    {
        var Status:Bool = false
        let url = NSURL(string: "https://www.google.com/.eg")
        var request = URLRequest(url: url! as URL)
        //request.timeoutInterval = 3.0
        request.httpMethod = "Get"
        let (_, _, error) = URLSession.shared.synchronousDataTask(urlrequest: request)
        if let error = error {
            print("Synchronous task ended with error: \(error)")
            return Status
        }
        else {
            print("Synchronous task ended without errors.")
            Status = true
            return Status
        }
    }
}



