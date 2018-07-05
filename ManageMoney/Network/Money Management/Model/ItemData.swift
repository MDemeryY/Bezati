//
//  ItemData.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-04.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

class ItemData {
  
  var id : Int?
  var name : String?
  var notes : String?
  var price : Int?
  var incomeCategoryId : Int?
  var outComeCategoryId : Int?
  var incomeCategoryName : String?
  var outComeCategoryName : String?
  var createDate : String?
  init(id : Int , name : String , notes : String , price : Int , incomeCategoryId : Int , outComeCategoryId : Int ,incomeCategoryName : String ,outComeCategoryName : String , createDate : String  ) {
    self.id = id
    self.name = name
    self.notes = notes
    self.price = price
    self.incomeCategoryId = incomeCategoryId
    self.outComeCategoryId = outComeCategoryId
    self.incomeCategoryName = incomeCategoryName
    self.outComeCategoryName = outComeCategoryName
    self.createDate = createDate
  }
  
}
