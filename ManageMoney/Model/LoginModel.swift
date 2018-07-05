//
//  LoginModel.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-04.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

class LoginandRegister {
    
    var email : String?
    var fullname : String?
    var accessToken : String?
    var tokenType : String?
    var code : Int?
    var requestDetails : String!
    
    init(email : String , fullName : String , accessToken : String , tokenType : String , code : Int , requestDetails : String) {
        self.email = email
        self.fullname = fullName
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.code = code
        self.requestDetails = requestDetails
    }
    
}
