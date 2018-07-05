
//
//  ٍallRequest.swift
//  Money Management
//
//  Created by Mohamed Ramadan on 2018-03-07.
//  Copyright © 2018 Rachel. All rights reserved.
//

import Foundation
import Alamofire

public  class AllRequset   {
    
    static var request : AllRequset?
    
    //------------------------------ LOGin ---------------------------------------------
    func login (email : String , password : String , completion : @escaping ((LoginandRegister)->Void)){
        var login:LoginandRegister?
        let url = Constants.baseUrl + Constants.LoginAndRegister.login
        let  params :[String:Any] = ["Email":email , "Password": password]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(){
            respons in
            switch respons.result{
            case .success(let _):
                
                let dict = respons.result.value as! [String:Any]
                let email = dict["Email"] as? String ?? ""
                let fullnamne = dict["FullName"] as? String ?? ""
                let accessToken = dict["access_token"] as? String ?? ""
                let tokenType = dict["token_type"] as? String ?? ""
                let code = dict["Code"] as? Int ?? 0
                let resultDetails = dict["RequstDetails"] as? String ?? ""
                let loginOb = LoginandRegister(email: email, fullName: fullnamne, accessToken: accessToken, tokenType: tokenType, code: code, requestDetails: resultDetails)
                login = loginOb
                DispatchQueue.main.async {completion(login!)}
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    // --------------------------- Rigester -------------------
    func  register (email : String  ,name : String ,password : String ,concurencyId : Int
        , dailyAlert : Bool ,badgetSelected : Bool,beginDayWeak : Int,badgetValue :Int
        ,completion : @escaping ((LoginandRegister)->Void) ){
        var register:LoginandRegister?
        
        let parms: [String : Any] =
            ["Email":email, "FullName":name, "ConcuranceyId" : concurencyId ,"Password":password,"BegainDayOfWeek" : beginDayWeak ,"BadgetSelected ": badgetSelected , "BadgetValue":badgetValue,"DailyAlert": dailyAlert ]
        let url = Constants.baseUrl + Constants.LoginAndRegister.register
        print(parms)
        Alamofire.request(url, method: .post, parameters: parms, encoding: JSONEncoding.default, headers: nil ).responseJSON{
            respons in
            switch respons.result{
            case .success(_):
                let dict = respons.result.value as! [String:Any]
                let email = dict["Email"] as? String ?? ""
                let fullnamne = dict["FullName"] as? String ?? ""
                let accessToken = dict["access_token"] as? String ?? ""
                let tokenType = dict["token_type"] as? String ?? ""
                let code = dict["Code"] as? Int ?? 0
                let resultDetails = dict["RequstDetails"] as?  String ?? ""
                let loginOb = LoginandRegister(email: email, fullName: fullnamne, accessToken: accessToken, tokenType: tokenType, code: code, requestDetails: resultDetails)
                register = loginOb
                DispatchQueue.main.async {completion(register!)}
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    // ---------------  3  /api/Concuranceys ------------------------------------------------------------
    func getConcurrency (completion: @escaping (([Concuranceys]) -> Void)){
        var  ConcuranceysArr = [Concuranceys]()
        let url = "http://gasem1234-001-site1.dtempurl.com/api/Concuranceys"
        Alamofire.request(url).responseJSON(){
            respons in
            switch respons.result{
            case .success(let _):
                let dict = respons.result.value as? [[String :Any]]
                let firstFive = dict![0...5]
                
                for item in firstFive{
                    let id = item["Id"] as! Int
                    let country = item["Country"] as! String
                    let name  = item["Name"] as! String
                    let   concurencyOb = Concuranceys(id: id, country: country, name: name)
                    ConcuranceysArr.append(concurencyOb)
                }
                DispatchQueue.main.async {completion(ConcuranceysArr)}
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    // -------------------- Forget PassWord  --------------
    
    func getPassWordG(email : String ,  completion :@escaping ((EmailStatus)->Void )) {
        var emailStatus : EmailStatus!
        let url = Constants.baseUrl + "/api/ForgetPassword" + "?Email=\(email)"
        Alamofire.request(url ).responseJSON(){
            respons in
            switch respons.result{
            case .success(let value):
                let dict = respons.result.value as! [String :Any]
                
                let code  = dict["Code"] as! Int
                let message  = dict["RequstDetails"] as! String
                
                let emailObj = EmailStatus(code: code, message: message)
                emailStatus = emailObj
                DispatchQueue.main.async {completion(emailStatus)}
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    // ---------------  3  /api/Concuranceys
    //------------------------------------------------------------
    
    
    
    
    // ------------------------------------------ Get Currency With Id -----------------
    
    func getConcurrencyWithId  ( id :Int , completion: @escaping ((Concuranceys) -> Void)){
        var  concuranceysId :Concuranceys!
        //  let params : [String:Any] = ["Id":id]
        let url = "http://gasem1234-001-site1.dtempurl.com/api/Concuranceys?Id=\(id)"
        Alamofire.request(url ).responseJSON(){
            respons in
            switch respons.result{
            case .success(let _):
                let dict = respons.result.value as! [String :Any]
                let id = dict["Id"] as! Int
                let country = dict["Country"] as! String
                let name  = dict["Name"] as! String
                
                let   concurencyOb = Concuranceys(id: id, country: country, name: name)
                concuranceysId = concurencyOb
                DispatchQueue.main.async {completion(concuranceysId)}
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    //---------------------- get concurrency with parameters --------------
    func getConcurrencyWithParameters( country : String , name : String , completion: @escaping ((Int) -> Void)){
        var  concuranceys :Concuranceys!
        let params : [String:Any] = [
            "Country":country ,
            "Name" : name
        ]
        let url = Constants.baseUrl + "/api/Concuranceys"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString{
                
                response in
                
                let statusCode = response.response?.statusCode
                
                completion(statusCode!)
                
        }
    }
    //----------------------------- add Country -------------------------
    
    func addCountry (country : String , name  : String){
        let url = "http://gasem1234-001-site1.dtempurl.com/api/Concuranceys"
        let params : [String:Any] = ["Country":country,"Name":name]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(){
            respons in
            switch respons.result{
            case .success(let _):
                
                print("Scusess ")
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
    // --------------------------  Get all Category ----------- Authorization-----------------------------
    // in come Category
    //Done
    func CategoriesInCome (accesToken :String , completion : @escaping  ((Category) ->Void )){
        let url = Constants.baseUrl + Constants.Categories.categoriesIncome
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + " " + accesToken
        
        var allCatArr : [CategoryData] = []
        var category : Category!
        
        var money = 0
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            respons in
            switch respons.result{
            case .success(let value):
                let dict = respons.result.value as! [String :Any]
                let code  = dict["Code"] as! Int
                let requestDetails  = dict["RequstDetails"] as! String
                if let data   = dict["data"] as? [[String: Any]] {for cate in data {
                    let dataId = cate["Id"]as! Int
                    let name   = cate ["Name"] as! String
                    let icon = cate["Icon"] as! String
                    if let m = cate["Money"] as? NSNumber{
                       money =  m.intValue
                    }
                    
                    let budget = cate["Budget"] as! Int
                    let creatData = cate["CreateDate"] as! String
                    let cateOb = CategoryData(id: dataId, name: name, icon: icon, money: money, budget: budget, createDate: creatData)
                    allCatArr.append(cateOb)
                    }
                    let categoryOb = Category(code: code, requestDetails: requestDetails, data: allCatArr)
                    category = categoryOb
                    
                    DispatchQueue.main.async {completion(category)}
                    
                }
                completion(category)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    // ----- OutCome Caregory
    //Done
    
    func CategoriesOutCome (accesToken :String , completion : @escaping  ((Category) ->Void )){
        let url = Constants.baseUrl + Constants.Categories.categoriesOutCome
        var allCatArr : [CategoryData] = []
        var category : Category!
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accesToken
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            
            respons in
            var money = 0
            switch respons.result{
            case .success(let value):
                let dict = respons.result.value as! [String :Any]
                let code  = dict["Code"] as! Int
                let requestDetails  = dict["RequstDetails"] as! String
                if let data   = dict["data"] as? [[String: Any]]{
                    for cate in data {
                        
                        let dataId = cate["Id"]as! Int
                        let name   = cate ["Name"] as! String
                        let icon = cate["Icon"] as! String
                        if let m = cate["Money"] as? NSNumber {
                            money = m.intValue
                        }
                        let budget = cate["Budget"] as! Int
                        let creatData = cate["CreateDate"] as! String
                        let cateOb = CategoryData(id: dataId, name: name, icon: icon, money: money, budget: budget, createDate: creatData)
                        allCatArr.append(cateOb)
                    }
                    let categoryOb = Category(code: code, requestDetails: requestDetails, data: allCatArr)
                    category = categoryOb
                    
                    DispatchQueue.main.async {
                        completion(category)
                    }
                }
                completion(category)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    // resetPasswordto forget your password
    func resetPassword (email : String ,newPassword : String , code : Int , completion :@escaping ((EmailStatus)->Void )) {
        var emailStatus : EmailStatus!
        let params : [String:Any] = ["Email":email , "Password" :newPassword , "Code":code]
        let url = Constants.baseUrl + "/api/ForgetPassword" + "?Email=\(email)"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(){
            respons in
            switch respons.result{
            case .success(let value):
                let dict = respons.result.value as! [String :Any]
                let code  = dict["Code"] as! Int
                let message  = dict["RequstDetails"] as! String
                
                let emailObj = EmailStatus(code: code, message: message)
                emailStatus = emailObj
                DispatchQueue.main.async {completion(emailStatus)}
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    // ---------- reset PassWord
    
    func resetPassword(newPassword : String ,oldPassword : String ,accessToken:String ,  success :@escaping ((EmailStatus)->Void ) , error :@escaping ((String)->())){
        var emailStatus : EmailStatus!
        let url = Constants.baseUrl + "/api/ResetPassword"
        
        let params : [String : Any] = [
            "NewPassword" :   newPassword ,
            "OldPassword" : oldPassword
        ]

        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            response in
            
            print(response.result)
            
            switch response.result{
            case .success(_):
                let dict = response.result.value as! [String :Any]
                if let code  = dict["Code"] as? Int {
                    if let message  = dict["RequstDetails"] as? String {
                        DispatchQueue.main.async {success(EmailStatus(code: code, message: message))}
                    }
                    error("Password Changed Failed")
                }
                
                error("Password Changed Failed")
                
            case .failure(let _):
                error("Password Changed Failed")
            }
            
        }
        
    }
    
    // -------get user info
    //Done
    func getUserInfo(accessToken : String , completion : @escaping  ((UserInfo) ->Void )){
        let url = Constants.baseUrl + "/api/GetUserInfo"
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            
            response in
            
            print("response \(response)")
            switch response.result {
                
            case .success( _):
                
                let dict = response.result.value as! [String : Any]
                
                
                let Email = dict["Email"] as? String ?? ""
                let FullName = dict["FullName"] as? String ?? ""
                let Code = dict["Code"] as? Int ?? 0
                let RequstDetails = dict["RequstDetails"] as? String ?? ""
                let ConcuranceyId = dict["ConcuranceyId"] as? Int ?? 0
                let Concurancey = dict["Concurancey"] as? String ?? ""
                let DailyAlert = dict["DailyAlert"] as? Bool ?? false
                let BadgetSelected = dict["BadgetSelected"] as? Bool ?? false
                let BadgetValue = dict["BadgetValue"] as? Int ?? 0
                let BegainDay = dict["BegainDay"] as? Int ?? 0
                
                
                let userInfo = UserInfo(Email: Email, FullName: FullName, Code: Code, RequstDetails: RequstDetails, ConcuranceyId: ConcuranceyId, Concurancey: Concurancey, DailyAlert: DailyAlert, BadgetSelected: BadgetSelected, BadgetValue: BadgetValue, BegainDay: BegainDay)
                
                completion(userInfo)
                
            case .failure(let fail) :
                print(fail.localizedDescription)
            }
        }
    }
    
    //-------------------------- update user information
    //Done
    func updateUserInfo(Email : String ,
                        FullName : String ,
                        ConcuranceyId : Int ,
                        BadgetSelected : Bool ,
                        BadgetValue : Int ,
                        DailyAlert : Bool ,
                        BegainDay : Int ,
                        accessToken : String
        , success: @escaping ((EmailStatus) -> ())
        , error: @escaping ((String ) -> ())
        )
        
    {
        let url = Constants.baseUrl + "/api/UpdateUserInfo"
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        var emailStatus : EmailStatus!
        
        let params : [String : Any] = [
            "Email" : Email,
            "FullName" : FullName,
            "ConcuranceyId" : ConcuranceyId ,
            "BadgetSelected" : BadgetSelected,
            "BadgetValue" : BadgetValue,
            "DailyAlert" : DailyAlert,
            "BegainDay" : BegainDay
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            response in
            
            switch response.result{
            case .success( _):
                let dict = response.result.value as! [String :Any]
                
                let code  = dict["Code"] as? Int ?? 0
                let message  = dict["RequstDetails"] as? String ?? ""
                
                let emailObj = EmailStatus(code: code, message: message)
                emailStatus = emailObj
                DispatchQueue.main.async {success(emailStatus)}
            case .failure(let err):
                print(err.localizedDescription)
                DispatchQueue.main.async {error("Error to updating Your Infromation")}
            }
        }
    }
    
    //----------------- delete category -----------
    // done
    func deleteCategory(id : Int , completion : @escaping  ((Int) ->() )) {
        
        let url = Constants.baseUrl + "/api/DeleteCategory/\(id)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseString{
                response in
                let statusCode = response.response?.statusCode
                completion(statusCode!)
                
        }
    }
    //---------------- get items --------
    
    //Done
    func getItems (accessToken : String , completion : @escaping  (([ItemData]) ->Void )){
        let url = Constants.baseUrl + "/api/Items"
        var itemDataArr = [ItemData]()
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            response in
            switch response.result {
            case .success(_):
                let dict = response.result.value as! [String : Any]
                //        let code = dict["Code"] as! Int
                //        let requestdetails = dict["RequstDetails"] as! String
                if let data = dict["data"] as? [[String: Any]]{
                    for result in data {
                        let Id = result["Id"] as! Int
                        let Name   = result ["Name"] as! String
                        let Notes = result["Notes"] as! String
                        let Price = Int(result["Price"] as! Double)
                        let IncomeCategoryId = result["IncomeCategoryId"] as! Int
                        let OutComeCategoryId = result["OutComeCategoryId"] as! Int
                        let IncomeCategoryName = result["IncomeCategoryName"] as! String
                        let OutComeCategoryName = result["OutComeCategoryName"] as! String
                        let CreateDate = result["CreateDate"] as! String
                        
                        let resultObj = ItemData(id: Id, name: Name, notes: Notes, price: Price, incomeCategoryId: IncomeCategoryId, outComeCategoryId: OutComeCategoryId, incomeCategoryName: IncomeCategoryName, outComeCategoryName: OutComeCategoryName, createDate: CreateDate)
                        
                        itemDataArr.append(resultObj)
                        
                    }
                    completion(itemDataArr)
                }
                completion(itemDataArr)
                
            case .failure(let fail):
                print(fail.localizedDescription)
                
            }
        }
        
    }
    
    
    ////////////get daily item////////////
    func getDailyItems (accessToken : String , completion : @escaping  (([ItemData]) ->Void )){
        let url = Constants.baseUrl + "/api/ItemDaily"
        var itemDataArr = [ItemData]()
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            response in
            switch response.result {
            case .success(_):
                let dict = response.result.value as! [String : Any]
                print(dict)
                //        let code = dict["Code"] as! Int
                //        let requestdetails = dict["RequstDetails"] as! String
                if let data = dict["data"] as? [[String: Any]] {
                    for result in data {
                        let Id = result["Id"] as! Int
                        let Name   = result ["Name"] as! String
                        let Notes = result["Notes"] as! String
                        let Price = Int(result["Price"] as! Double)
                        let IncomeCategoryId = result["IncomeCategoryId"] as! Int
                        let OutComeCategoryId = result["OutComeCategoryId"] as! Int
                        let IncomeCategoryName = result["IncomeCategoryName"] as! String
                        let OutComeCategoryName = result["OutComeCategoryName"] as! String
                        let CreateDate = result["CreateDate"] as! String
                        
                        let resultObj = ItemData(id: Id, name: Name, notes: Notes, price: Price, incomeCategoryId: IncomeCategoryId, outComeCategoryId: OutComeCategoryId, incomeCategoryName: IncomeCategoryName, outComeCategoryName: OutComeCategoryName, createDate: CreateDate)
                        
                        itemDataArr.append(resultObj)
                        
                    }
                    completion(itemDataArr)
                }
                completion(itemDataArr)
            case .failure(let fail):
                print(fail.localizedDescription)
                
            }
        }
        
    }
    ///////////////
    //------------- get items with id
    
    func getItemsWithId(id : Int ,completion : @escaping  (([ItemData]) ->Void )){
        
        let url = Constants.baseUrl + "/api/Items/\(id)"
        var itemDataArr = [ItemData]()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                
                switch response.result {
                case .success(_):
                    let dict = response.result.value as! [String : Any]
                    
                    let data = dict["data"] as! [[String: Any]]
                    for result in data {
                        let Id = result["Id"] as! Int
                        let Name   = result ["Name"] as! String
                        let Notes = result["Notes"] as! String
                        let Price = result["Price"] as! Int
                        let IncomeCategoryId = result["IncomeCategoryId"] as! Int
                        let OutComeCategoryId = result["OutComeCategoryId"] as! Int
                        let IncomeCategoryName = result["IncomeCategoryName"] as! String
                        let OutComeCategoryName = result["OutComeCategoryName"] as! String
                        let CreateDate = result["CreateDate"] as! String
                        
                        let resultObj = ItemData(id: Id, name: Name, notes: Notes, price: Price, incomeCategoryId: IncomeCategoryId, outComeCategoryId: OutComeCategoryId, incomeCategoryName: IncomeCategoryName, outComeCategoryName: OutComeCategoryName, createDate: CreateDate)
                        
                        itemDataArr.append(resultObj)
                    }
                    completion(itemDataArr)
                case .failure(let fail):
                    print(fail.localizedDescription)
                    
                }
                
        }
        
    }
    
    //----------- insert items
    
    func insertItems(Id : Int ,Name : String , Notes : String , Price : Double , IncomeCategoryId : Int ,   OutComeCategoryId : Int , accessToken : String , success:@escaping ((EmailStatus) -> Void) , error: @escaping ((String) -> Void) ){
        let url = Constants.baseUrl + "/api/Items"
        var emailStatus : EmailStatus!
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        let params : [String:Any] =  [
            "Id":Id,
            "Name": Name,
            "Notes":Notes,
            "Price":Price,
            "IncomeCategoryId":IncomeCategoryId,
            "OutComeCategoryId":OutComeCategoryId
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                
                response in
                
                switch response.result{
                case .success(_):
                    
                    let result = response.result.value as! NSDictionary
                    
                    let mycode = result["Code"] as? Int
                    
                    //                    let dict = response.result.value as! [String :Any]
                    //                    let code = dict["Code"] as! Int
                    print("\(mycode)")
                    if let code  = result["Code"] as? Int {
                        if let message  = result["RequstDetails"] as? String {
                            let emailObj = EmailStatus(code: code, message: message)
                            emailStatus = emailObj
                            DispatchQueue.main.async {success(emailStatus)}
                        }
                    }
                    
                case .failure(_):
                    print("Error to add new item")
                }
                
        }
        
    }
    
    //------------- update items
    func updateItems(Id : Int ,Name : String , Notes : String , Price : Int , IncomeCategoryId : Int ,   OutComeCategoryId : Int , accessToken : String , success:@escaping ((EmailStatus) -> Void) , error: @escaping ((String) -> Void) ){
        let url = Constants.baseUrl + "/api/Items"
        var emailStatus : EmailStatus!
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        let params : [String : Any] = [
            "Id":Id,
            "Name":Name,
            "Notes":Notes,
            "Price":Price,
            "IncomeCategoryId":IncomeCategoryId,
            "OutComeCategoryId": OutComeCategoryId
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                
                response in
                print(response.result.value)
                //        switch response.result{
                //
                //        case .success(_):
                //            let dict = response.result.value as! [String :Any]
                //
                //            let code  = dict["Code"] as! Int
                //            let message  = dict["RequstDetails"] as! String
                //
                //            let emailObj = EmailStatus(code: code, message: message)
                //            emailStatus = emailObj
                //           DispatchQueue.main.async {success(emailStatus)}
                //        case .failure(_):
                //            error("Error to update this category , Please try again!")
                //        }
                
        }
        
    }
    
    //------------- delete items
    
    func deleteItem(id : Int , accessToken:String ,  completion: @escaping ((Int) -> Void)) {
        let url = Constants.baseUrl + "/api/DeleteItem/\(id)"
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseString{
                response in
                let statusCode = response.response?.statusCode
                completion(statusCode!)
        }
    }
    //--------------- get item manage
    func getItemManage(day : Int , accessToken : String , completion : @escaping  (([ItemData]) ->Void )){
        
        let url = Constants.baseUrl + "/api/ItemMange/?Day=\(day)"
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        //let params : [String : Any] = ["Day" : day ]
        var itemDataArr = [ItemData]()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(){
                response in
                switch response.result {
                case .success(_):
                    let dict = response.result.value as! [String : Any]
                    // let code = dict["Code"] as! Int
                    guard   (dict["RequstDetails"] as? String) != nil  else {return}
                    let data = dict["data"] as! [[String: Any]]
                    
                    for result in data {
                        let Id = result["Id"] as! Int
                        let Name   = result ["Name"] as! String
                        let Notes = result["Notes"] as! String
                        let Price = Int(result["Price"] as! Double)
                        let IncomeCategoryId = result["IncomeCategoryId"] as! Int
                        let OutComeCategoryId = result["OutComeCategoryId"] as! Int
                        let IncomeCategoryName = result["IncomeCategoryName"] as! String
                        let OutComeCategoryName = result["OutComeCategoryName"] as! String
                        let CreateDate = result["CreateDate"] as! String
                        
                        let resultObj = ItemData(id: Id, name: Name, notes: Notes, price: Price, incomeCategoryId: IncomeCategoryId, outComeCategoryId: OutComeCategoryId, incomeCategoryName: IncomeCategoryName, outComeCategoryName: OutComeCategoryName, createDate: CreateDate)
                        
                        itemDataArr.append(resultObj)
                        
                    }
                    //                    let itemObj = items(code: code, requestDetails: requestdetails, data: itemDataArr)
                    //
                    completion(itemDataArr)
                    
                case .failure(let fail):
                    print(fail.localizedDescription)
                    
                }
        }
        
    }
    
    //------------- item manage by week
    
    func getItemManageByweek(accessToken : String , completion : @escaping  (([ItemData]) ->Void )){
        
        let url = Constants.baseUrl + "/api/ItemMange"
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        var itemDataArr = [ItemData]()
        var _ : items!
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(){
            response in
            
            print("response \(response)")
            
            switch response.result {
            case .success( _):
                let dict = response.result.value as! [String : Any]
                
                //        let code = dict["Code"] as! Int
                //        let requestdetails = dict["RequstDetails"] as! String
                if let data = dict["data"] as? [[String: Any]] {
                    for result in data {
                        let Id = result["Id"] as! Int
                        let Name   = result ["Name"] as! String
                        let Notes = result["Notes"] as! String
                        let Price = Int(result["Price"] as! Double)
                        let IncomeCategoryId = result["IncomeCategoryId"] as! Int
                        let OutComeCategoryId = result["OutComeCategoryId"] as! Int
                        let IncomeCategoryName = result["IncomeCategoryName"] as! String
                        let OutComeCategoryName = result["OutComeCategoryName"] as! String
                        let CreateDate = result["CreateDate"] as! String
                        
                        let resultObj = ItemData(id: Id, name: Name, notes: Notes, price: Price, incomeCategoryId: IncomeCategoryId, outComeCategoryId: OutComeCategoryId, incomeCategoryName: IncomeCategoryName, outComeCategoryName: OutComeCategoryName, createDate: CreateDate)
                        
                        itemDataArr.append(resultObj)
                    }
                    completion(itemDataArr)
                }
            case .failure(let fail):
                print(fail.localizedDescription)
                
            }
        }
    }
    //-------------- get item category by id
    
    func getItemCategory(id : Int , accessToken : String ,  completion : @escaping  (([ItemData]) ->Void )){
        let url = Constants.baseUrl + "/api/ItemCategory/\(id)"
        
        //let params : [String : Any] = ["id" : id ]
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        
        var itemDataArr = [ItemData]()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(){
                response in
                switch response.result {
                case .success(_):
                    let dict = response.result.value as! [String : Any]
                    
                    if let code = dict["Code"] as? Int{
                        if  let requestdetails = dict["RequstDetails"] as? String{
                            let data = dict["data"] as! [[String: Any]]
                            
                            for result in data {
                                let Id = result["Id"] as! Int
                                let Name   = result ["Name"] as! String
                                let Notes = result["Notes"] as! String
                                let Price = result["Price"] as! Int
                                let IncomeCategoryId = result["IncomeCategoryId"] as! Int
                                let OutComeCategoryId = result["OutComeCategoryId"] as! Int
                                let IncomeCategoryName = result["IncomeCategoryName"] as! String
                                let OutComeCategoryName = result["OutComeCategoryName"] as! String
                                let CreateDate = result["CreateDate"] as! String
                                
                                let resultObj = ItemData(id: Id, name: Name, notes: Notes, price: Price, incomeCategoryId: IncomeCategoryId, outComeCategoryId: OutComeCategoryId, incomeCategoryName: IncomeCategoryName, outComeCategoryName: OutComeCategoryName, createDate: CreateDate)
                                
                                itemDataArr.append(resultObj)
                                
                            }
                            completion(itemDataArr)
                        }
                    }
                    
                case .failure(let fail):
                    print(fail.localizedDescription)
                    
                }
        }
    }
    
    //-----------------
    
    
    
    //---------------- insert category income
    
    func insertCategoryIncome( id : Int , price: Double , name : String , icon : String , accessToken : String, completion: @escaping ((Int) -> Void)){
        
        let params : [String:Any] = [
            "Name":name,
            "Icon": icon,
            "Price":price,
            "Id":id
        ]
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        
        let url = Constants.baseUrl + "/api/CategoriesIncome"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseString{
                response in
                let statusCode = response.response?.statusCode
                completion(statusCode!)
        }
    }
    //-------------- update category income
    func updateCategoryIncome( id : Int , price: Double , name : String , icon : String , completion: @escaping ((Int) -> Void)){
        var  concuranceys :Concuranceys!
        let params : [String:Any] = [
            "Name":name,
            "Icon": icon,
            "Price":price,
            "Id":id
            
        ]
        let url = Constants.baseUrl + "/api/CategoriesIncome"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString{
                
                response in
                
                let statusCode = response.response?.statusCode as? Int
                
                completion(statusCode!)
                
        }
    }
    
    //------------- insert category outcome
    
    func insertCategoryOutCome( id : Int , price: Double , name : String , icon : String , accessToken : String, completion: @escaping ((Int) -> Void)){
        
        
        let params : [String:Any] = [
            "Name":name,
            "Icon": icon,
            "Price":price,
            "Id":id
        ]
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + accessToken
        
        
        let url = Constants.baseUrl + "/api/CategoriesOutCome"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseString{
                response in
                let statusCode = response.response?.statusCode
                completion(statusCode!)
        }
    }
    //----------- update category out come
    
    func updateCategoryOutCome( id : Int , price: Double , name : String , icon : String , completion: @escaping ((Int) -> Void)){
        var  concuranceys :Concuranceys!
        let params : [String:Any] = [
            "Name":name,
            "Icon": icon,
            "Price":price,
            "Id":id
            
        ]
        let url = Constants.baseUrl + "/api/CategoriesOutCome"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString{
                
                response in
                
                let statusCode = response.response?.statusCode as? Int
                
                completion(statusCode!)
                
        }
    }
    //-------- go to next
    
    func goToNext(completion: @escaping (([GoToNextData]) -> Void)){
        let url = Constants.baseUrl + "/api/GoToNext"
        var gotoNextArr = [GoToNextData]()
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + HandleToken.token
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(){
                response in
                switch response.result {
                case .success(let value):
                    let dict = response.result.value as! [String : Any]
                    let code = dict["Code"] as! Int
                    let requestdetails = dict["RequstDetails"] as! String
                    let data = dict["data"] as! [[String: Any]]
                    
                    for result in data {
                        //                        let Id = result["Id"] as! Int
                        //                        let Name   = result ["Name"] as! String
                        //                        let Icon = result["Icon"] as! String
                        let Money = result["Money"] as! Int
                        let Budget = result["Budget"] as! Int
                        let Month = result["Month"] as! Int
                        let Year = result["Year"] as! Int
                        
                        let resultObj = GoToNextData(id: 0, Name: "Name", icon: "Icon", money: Money, budget: Budget, month: Month, year: Year)
                        gotoNextArr.append(resultObj)
                        
                    }
                    //                    let itemObj = GoToNext(code: code, RequstDetails: requestdetails, data: gotoNextArr)
                    //                    item = itemObj
                    completion(gotoNextArr)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
        }
        
    }
    //------------ go to next with month
    
    func goToNextwithMonth(month : Int ,completion: @escaping (([GoToNextData]) -> Void)){
        let url = Constants.baseUrl + "/api/GoToNext/\(month)"
        var gotoNextArr = [GoToNextData]()
        
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + HandleToken.token
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(){
                response in
                switch response.result {
                case .success(_):
                    if let dict = response.result.value as? [String : Any]{
                        if let data = dict["data"] as? [[String: Any]]{
                            for result in data {
                                //let Id = result["Id"] as! Int
                                //let Name   = result ["Name"] as! String
                                //let Icon = result["Icon"] as! String
                                let Money = result["Money"] as! Int
                                let Budget = result["Budget"] as! Int
                                let Month = result["Month"] as! Int
                                let Year = result["Year"] as! Int
                                let resultObj = GoToNextData(id: 0, Name: "Name", icon: "Icon", money: Money, budget: Budget, month: Month, year: Year)
                                gotoNextArr.append(resultObj)
                            }
                            completion(gotoNextArr)
                        }
                    }
                case .failure(let fail):
                    print(fail.localizedDescription)
                    
                }
        }
        
    }
    
    //-------------- go to next category and Reset Category OutCome And make Statistic
    func goToNextResetCategory(completion: @escaping ((Int) -> Void)){
        
        let url = Constants.baseUrl + "/api/GoToNext"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseString{
                
                response in
                
                let statusCode = response.response?.statusCode as? Int
                
                completion(statusCode!)
                
        }
        
    }
    //-------------------- delete all data
    func deleteAllData(completion: @escaping ((Int) -> Void)){
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + HandleToken.token
        
        let url = Constants.baseUrl + "/api/DeleteAllData"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseString{
                response in
                let statusCode = response.response?.statusCode
                completion(statusCode!)
        }
    }
    //---------- get all data
    func getAllData(completion: @escaping ((AllData) -> Void)){
        
        var headers: [String:String] = [:]
        headers["Content-type"] = "application/json"
        headers["Authorization"] = "bearer " + HandleToken.token
        
        let url = Constants.baseUrl + "/api/GetAllData"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                response in
                switch response.result {
                case .success(_):
                    let dict = response.result.value as! [String : Any]
                    let url = dict["Url"] as? String ?? ""
                    let code = dict["Code"] as? Int ?? 0
                    let requstDetails = dict["RequstDetails"] as? String ?? ""
                    completion(AllData(url: url, code: code, requstDetails: requstDetails))
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
        }
    }
}
