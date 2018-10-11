//
//  MDAPIManager.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/10/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MDAPIManager{
    
    public static let instance = MDAPIManager()
    
    private lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "medicalcare")
        configuration.timeoutIntervalForRequest = 60.0
        configuration.timeoutIntervalForResource = 60.0
        var manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    func login(email: String, password: String, success: @escaping (String) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        let urlLogin = URL(string: kAPILogin)
        
        let param  : Parameters = ["email" : email, "password" : password]
        
        let manager = self.sessionManager
        
        manager.request(urlLogin!, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"]  as? String ?? ""
                if code == 200{
                    self.getInfoUser(email: email, success: {susscess in
                        print(success)
                        success(susscess)
                    }, failure: {fail, err in
                        failure(false, err)
                    })
                }else if code == 400 || code == 401{
                    failure(true,  msg )  // add target goto login view
                }else{
                    failure(false,  msg )
                }
            }else{
                if let error = response.result.error{
                    print(error)
                    if error._code == NSURLErrorTimedOut{
                        failure(false, kErrorTimeOutText)
                        return
                    }
                }
                failure(false, kErrorText)
            }
            
        }
    }
    
    func getInfoUser( email : String ,success: @escaping (String) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetUserInfo)
        let param  : Parameters = ["email" : email]
        let manager = self.sessionManager
        manager.request(urlgetInfo!, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"] as? String ?? ""
                if code == 200{
                    do{
                        let userObjectSave = try JSONDecoder().decode(UserApi.self, from: response.data!)
//                        print(userObjectSave)
//                        let placesData = NSKeyedArchiver.archivedData(withRootObject: userObjectSave)
                        if let userData = try?  JSONEncoder().encode(userObjectSave.data){
                            defaultLogin.set(userData , forKey: kUserDefaultkeyLogin)
                            defaultLogin.synchronize()
                            success(msg)
                        }else{
                            failure(false, kErrorText)
                        }
                    }catch{
                        failure(false, kErrorText)
                    }
                    
                }else if code == 400 || code == 401{
                    failure(true,  msg)  // add target goto login view
                }else{
                    failure(false,  msg)
                }
                
            }else{
                if let error = response.result.error{
                    print(error)
                    if error._code == NSURLErrorTimedOut{
                        failure(false, kErrorTimeOutText)
                        return
                    }
                }
                failure(false, kErrorText)
            }
        }
    }
    
    func register(userInfo : UserObject,success: @escaping (String) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        let urlLogin = URL(string: kAPIRegister)
        
        let jsonData = try! JSONEncoder().encode(userInfo)
        let jsonString = String(data: jsonData, encoding: .utf8)!
//        print(jsonString)
        guard let data = convertToDictionary(text: jsonString) else{
            return
        }
        let manager = self.sessionManager
        
        manager.request(urlLogin!, method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"]  as? String ?? ""
                if code == 200{
                    print(msg)
                    self.getInfoUser(email: userInfo.email!, success: {susscess in
                        success(susscess)
                    }, failure: {fail, err in
                        failure(false, err)
                    })
                }else if code == 400 || code == 401{
                    failure(true,  msg )  // add target goto login view
                }else{
                    failure(false,  msg )
                }
            }else{
                if let error = response.result.error{
                    print(error)
                    if error._code == NSURLErrorTimedOut{
                        failure(false, kErrorTimeOutText)
                        return
                    }
                }
                failure(false, kErrorText)
            }
            
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getAllHospital(url : String ,success: @escaping ([Hospital]) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: url)
        let param  : Parameters = ["idquest" : "1"]
        let manager = self.sessionManager
        manager.request(urlgetInfo!, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"] as? String ?? ""
                if code == 200{
                    do{
                       let dataProduct = try JSONDecoder().decode(AllHospitalApi.self, from: response.data!)
                        success(dataProduct.data!)
                    }catch{
                        failure(false, kErrorText)
                    }
                    
                }else if code == 400 || code == 401{
                    failure(true,  msg)  // add target goto login view
                }else{
                    failure(false,  msg)
                }
                
            }else{
                if let error = response.result.error{
                    print(error)
                    if error._code == NSURLErrorTimedOut{
                        failure(false, kErrorTimeOutText)
                        return
                    }
                }
                failure(false, kErrorText)
            }
        }
    }
    
    func getAllEmergency(success: @escaping ([Emergency]) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetAllEmergency)
        let param  : Parameters = ["idquest" : "1"]
        let manager = self.sessionManager
        manager.request(urlgetInfo!, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"] as? String ?? ""
                if code == 200{
                    do{
                        let dataProduct = try JSONDecoder().decode(AllEmergencyApi.self, from: response.data!)
                        success(dataProduct.data!)
                    }catch{
                        failure(false, kErrorText)
                    }
                    
                }else if code == 400 || code == 401{
                    failure(true,  msg)  // add target goto login view
                }else{
                    failure(false,  msg)
                }
                
            }else{
                if let error = response.result.error{
                    print(error)
                    if error._code == NSURLErrorTimedOut{
                        failure(false, kErrorTimeOutText)
                        return
                    }
                }
                failure(false, kErrorText)
            }
        }
    }
    
    func getAllInfoFindDoctor(success: @escaping (InfofindDoctor) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetAllInfoFindDoctor)
        let param  : Parameters = ["id" : "1"]
        let manager = self.sessionManager
        manager.request(urlgetInfo!, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"] as? String ?? ""
                if code == 200{
                    do{
                        let dataProduct = try JSONDecoder().decode(AllInfofindDoctorApi.self, from: response.data!)
                        success(dataProduct.data!)
                    }catch{
                        failure(false, kErrorText)
                    }
                    
                }else if code == 400 || code == 401{
                    failure(true,  msg)  // add target goto login view
                }else{
                    failure(false,  msg)
                }
                
            }else{
                if let error = response.result.error{
                    print(error)
                    if error._code == NSURLErrorTimedOut{
                        failure(false, kErrorTimeOutText)
                        return
                    }
                }
                failure(false, kErrorText)
            }
        }
    }
}
