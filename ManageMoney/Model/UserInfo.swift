//
//  UserInfo.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-19.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

class UserInfo {
    
    var  Email: String?
    var FullName: String?
    var Code : Int?
    var RequstDetails : String?
    var  ConcuranceyId : Int?
    var Concurancey : String?
    var  DailyAlert : Bool?
    var BadgetSelected : Bool?
    var BadgetValue : Int?
    var BegainDay : Int?
    
    init(Email : String ,FullName : String , Code : Int , RequstDetails : String , ConcuranceyId : Int , Concurancey : String , DailyAlert : Bool , BadgetSelected : Bool , BadgetValue : Int ,  BegainDay : Int) {
        self.Email = Email
        self.FullName = FullName
        self.Code = Code
        self.RequstDetails = RequstDetails
        self.ConcuranceyId = ConcuranceyId
        self.Concurancey = Concurancey
        self.DailyAlert = DailyAlert
        self.BadgetSelected = BadgetSelected
        self.BadgetValue = BadgetValue
        self.BegainDay = BegainDay
        
    }
    
}
