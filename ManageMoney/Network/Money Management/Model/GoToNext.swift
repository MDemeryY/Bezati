//
//  GoToNext.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-19.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

class GoToNext {
    
    var  Code : Int?
     var RequstDetails : String?
    var data : [GoToNextData]?
    
    init( code : Int ,RequstDetails : String , data : [GoToNextData] ){
        self.Code = code
        self.RequstDetails = RequstDetails
        self.data = data
    }

}
