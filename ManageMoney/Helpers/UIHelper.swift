//
//  UIHelper.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/2/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
class UIHelper {
    func assignbackground(backgroundName:String , view:UIView){
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.bottomRight
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.alpha = 0.8
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//    func setBackGroundForTableView() {
//        var imageView : UIImageView!
//        imageView = UIImageView(frame: view.bounds)
//        imageView.contentMode =  UIViewContentMode.bottomRight
//        imageView.clipsToBounds = true
//        imageView.image = background
//        imageView.alpha = 0.8
//        imageView.center = view.center
//        view.addSubview(imageView)
//        view.sendSubview(toBack: imageView)
//    }
}

