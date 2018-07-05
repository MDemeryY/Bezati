//
//  AllData.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/22/18.
//  Copyright © 2018 demi. All rights reserved.
//

import Foundation


class AllData {
    let url : String
    let code  : Int
    let requstDetails:String
    init(url:String , code : Int, requstDetails  : String) {
        self.url = url
        self.code = code
        self.requstDetails = requstDetails
    }
}
