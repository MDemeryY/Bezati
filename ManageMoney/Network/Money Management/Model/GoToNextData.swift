//
//  GoToNextData.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-19.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

class GoToNextData {
    
    var  Id : Int?
    var  Name : String?
    var  Icon : String?
    var  Money : Int?
    var  Budget :Int?
    var Month : Int?
    var  Year : Int?
    
    init(id : Int , Name : String , icon : String , money : Int , budget : Int , month : Int , year : Int) {
        self.Id = id
        self.Name = Name
        self.Icon = icon
        self.Money = money
        self.Budget = budget
        self.Month = month
        self.Year = year
    }

}
