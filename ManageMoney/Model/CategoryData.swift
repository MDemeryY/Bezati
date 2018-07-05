//
//  CategoryData.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-04.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

class CategoryData {
    
    var id : Int?
    var name : String?
    var icon : String?
    var money : Int?
    var budget : Int?
    var createDate : String?
  init(id : Int,name : String,icon : String,money : Int,budget : Int,createDate : String) {
    self.id = id
    self.name = name
    self.icon = icon
    self.money = money
    self.budget = budget
    self.createDate = createDate
  }

}
