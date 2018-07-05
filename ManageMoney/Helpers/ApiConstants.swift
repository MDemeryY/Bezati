//
//  Constants.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/12/18.
//  Copyright © 2018 demi. All rights reserved.
//

import Foundation

class HandleToken{
    
    static let ACCESS_TOKEN_KEY = "AccessToken"
    
    static var token: String {
        return (UserDefaults.standard.object(forKey: ACCESS_TOKEN_KEY) as? String) ?? ""
    }

    static func setToken(token:String){
        UserDefaults.standard.set(token, forKey: ACCESS_TOKEN_KEY)
    }
    
    static func removeToken(key:String){
        let def = UserDefaults.standard
        def.removeObject(forKey: "AccessToken")
    }
    
}
