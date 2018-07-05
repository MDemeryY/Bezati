//
//  DataConstants.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-04.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

struct DataConstants {
    
    
    struct LoginAndRegister {
        static  let Email = "Email"
        static let FullName = "FullName"
        static let access_token = "access_token"
        static let token_type = "token_type"
        static let Code = "Code"
        static let RequstDetails = "RequstDetails"
        static let ConcuranceyId = "ConcuranceyId"
        static let Password = "Password"
        static let BegainDayOfWeek = "BegainDayOfWeek"

    }
    
    struct  Concuranceys {
        static let id = "Id"
        static let country = "Country"
        static let name = "Name"
    }
    struct CategoriesIncomeAndOutCome {
        static let code = "Code"
        static let requstDetails = "RequstDetails"

        struct Data {
            static let id = "Id"
            static let name = "Name"
            static let icon = "Icon"
            static let money = "Money"
            static let budget = "Budget"
            static let createDate = "CreateDate"

        }
    }
    
    struct Item {
        
        static let code = "Code"
        static let requstDetails = "RequstDetails"
        struct Data {
            static let id = "Id"
            static let name = "Name"
            static let notes = "Notes"
            static let Price = "Price"
            static let incomeCategoryId = "IncomeCategoryId"
            static let outComeCategoryId = "OutComeCategoryId"
            static let outComeCategoryName = "OutComeCategoryName"
            static let createDate = "CreateDate"
        }

    }
    
}
