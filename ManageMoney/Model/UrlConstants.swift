//
//  UrlConstants.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-04.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation

struct Constants {
    
    static let baseUrl = "http://gasem1234-001-site1.dtempurl.com"
    static let forgetPassWord = "/api/ForgetPassword"
    struct LoginAndRegister {
        
        static let login = "/api/Login"
        static let register = "/api/Register"
        
    }
    struct Concurancey {
        
        static let concuranceys = "/api/Concuranceys"

    }
    struct Update {
        
        static let udateUserInfo = "/api/UpdateUserInfo"
       
    }
    
    struct Categories {
        
        static let categoriesIncome = "/api/CategoriesIncome"
        static let categoriesOutCome = "/api/CategoriesOutCome"
        static let deleteCategoryv = "/api/DeleteCategory"
        static let items = "/api/Items"
        static let deleteItems = "/api/DeleteItem"
    }
}
