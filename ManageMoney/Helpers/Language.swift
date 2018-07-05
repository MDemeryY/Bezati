//
//  Language.swift
//  localization
//
//  Created by Hassan Elgibali on 3/20/18.
//  Copyright © 2018 Hassan. All rights reserved.
//

import Foundation
import UIKit

class Language{
    
    class func currentLanguage ()->String{
        let def = UserDefaults.standard
        let lang = def.object(forKey: "AppleLanguages") as! NSArray
        let firstLang = lang.firstObject as! String
        return firstLang
    }
    
    func setNumberFormater(language:String , number:String) -> Double {
        let Formatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: language) as Locale!
        return Double(truncating: Formatter.number(from: number)!)
    }
    
    class func setAppLanguage(lang:String){
        let def = UserDefaults.standard
        if lang == "en"{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight

        }
        else{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft

        }
        def.set([lang , currentLanguage()], forKey: "AppleLanguages")
        def.synchronize()
    }
    
}
