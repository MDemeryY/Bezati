//
//  LocalizationHandeler.swift
//  localizationMe
//
//  Created by admin101 on 3/22/18.
//  Copyright © 2018 demi. All rights reserved.
//

import Foundation
import UIKit

class LocalizationHandeler {
    
    static let sharedInstance = LocalizationHandeler()
    var bundel: Bundle?
    
    private init() {
        
//        let lang = getLanguage()
        let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
        bundel =  Bundle(path: path!)
    }
    
    
    func localizeString(key: String, comment: String) -> String {
        return (bundel?.localizedString(forKey: key, value: comment, table: nil))!
    }
    
    func setLanguage(code: String) {
        var path: String?
        if code == "en"{
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight

        }
        else{
            path = Bundle.main.path(forResource: code, ofType: "lproj")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
             UITextField.appearance().makeTextWritingDirectionLeftToRight(nil)
        }
        bundel =  Bundle(path: path!)
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
    }
    
    func getLanguage() -> String {
        let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let currentLanguage = languages?.first
        
        return currentLanguage ?? "en"
    }
}

