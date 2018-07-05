//
//  AlamofireApiClient.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-05.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireClient{
    
    //MARK: Shared Instance
    
    static let sharedInstance =  AlamofireClient()
    
    fileprivate init() {
        
    }
    
    func executeGetRequest(url:String,parameters: [String:Any]?,header : [String:String]?,compilationHandler:@escaping (Any?,Error?) -> Void){
        
        Alamofire.request(url, parameters: parameters, headers: header).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(response.result.value!)
                    compilationHandler(data,nil)
                    
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                print (response.response?.description ?? "default value")
                compilationHandler(nil,response.result.error!)
                
                break
                
            }
        }
    }
    
    func executePostRequest(url:String,parameters: [String:Any]?,header : [String:String]?,compilationHandler:@escaping (Any?,Error?) -> Void){
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header ).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(response.result.value!)
                    compilationHandler(data,nil)
                }
                break
                
            case .failure(_):
                compilationHandler(nil,response.result.error!)
                print(response.result.error!)
                break
                
            }
        }
}

}
