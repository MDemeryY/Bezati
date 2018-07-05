//
//  DismissKeyboardExtension.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/30/18.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController {
    // End Keyboard
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.animationType = MBProgressHUDAnimation.zoomIn
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // Show Alert
    
    func alert(message: String, title: String) {
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
    
    func makeRadiosView(view:UIView) {
        view.layer.cornerRadius = view.layer.fs_height/2
        view.layer.masksToBounds = true
    }
    
    func makeRadiosView(view:UIView , radios:CGFloat) {
        view.layer.cornerRadius = radios
        view.layer.masksToBounds = true
    }
    
    func makeBorderForView(view:UIView){
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
    }
    
    func makeShadowForView(view:UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
