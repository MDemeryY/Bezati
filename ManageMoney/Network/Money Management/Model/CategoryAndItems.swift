//
//  CategoryAndItems.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-04.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

class Category {
    
    var code : Int?
    var requestDetails : String?
    var data : [CategoryData]?

  init(code : Int,requestDetails : String,data : [CategoryData]) {
      self.code = code
     self.data = data
    self.requestDetails = requestDetails
  }

}

class items {
    var code : Int?
    var requestDetails : String?
    var data : [ItemData]?
    
}
