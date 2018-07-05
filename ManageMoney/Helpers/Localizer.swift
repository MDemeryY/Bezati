//
//  Localizer.swift
//  localization
//
//  Created by Hassan Elgibali on 3/20/18.
//  Copyright © 2018 Hassan. All rights reserved.
//

import Foundation
import UIKit

class Localizer{
    class func DoTheExchange(){
        Exchange(className: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.customLocalizedStringForKey(key:value:table:)))
        
        //  Exchange(className: UIApplication.self, originalSelector: Selector("userInterfaceLayoutDirection"), overrideSelector: Selector("custom_userInterfaceLayoutDirection"))
    }
}

// 34an n8yr etgah sahm el back bta3 el view el tania lma el language tt8yr
//extension UIApplication {
//    var custom_userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
//        get{
//            var direction = UIUserInterfaceLayoutDirection.leftToRight
//            if Language.currentLanguage() == "ar-EG" {
//                direction = .rightToLeft
//            }
//            return direction
//        }
//    }
//}

extension Bundle {
    @objc func customLocalizedStringForKey(key:String, value:String, table tableName:String)->String{
        let currentLanguage = Language.currentLanguage()
        var bundle = Bundle()
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"){
            bundle=Bundle(path: path)!
        }else {
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundle=Bundle(path: path!)!
        }
        return bundle.customLocalizedStringForKey(key:key , value:value , table:tableName)
    }
}

func Exchange(className : AnyClass , originalSelector:Selector , overrideSelector:Selector){
    
    let originalMethod:Method = (class_getInstanceMethod(className, originalSelector))!
    let overrideMethod:Method = (class_getInstanceMethod(className, overrideSelector))!
    
    if class_addMethod(className, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)){
        class_replaceMethod(className, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    }else {
        method_exchangeImplementations(originalMethod, overrideMethod)
    }
    
}
