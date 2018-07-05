//
//  SwiftHelper.swift
//  ManageMoney
//
//  Created by Ahmed Fadl on 4/2/18.
//  Copyright © 2018 demi. All rights reserved.
//

import Foundation

class SwiftHelper {
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
