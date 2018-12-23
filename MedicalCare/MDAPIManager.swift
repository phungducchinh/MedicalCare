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
import CoreLocation
import MapKit
import SwiftyJSON

class MDAPIManager{
    
    public static let instance = MDAPIManager()
    
    private lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "medicalcare")
        configuration.timeoutIntervalForRequest = 120.0
        configuration.timeoutIntervalForResource = 120.0
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
    
    func register(userInfo : UserObject, apiStr: String, success: @escaping (String) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        let urlLogin = URL(string: apiStr)
        
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
    
    func getAllHospital(url : String , idquest: Int,success: @escaping ([Hospital]) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: url)
        let param  : Parameters = ["idquest" : idquest]
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
    
    func getAllInfoDoctor(objFindoctor: FindDoctor,success: @escaping ([Doctor]) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetAllInfoDoctor)
        let jsonData = try! JSONEncoder().encode(objFindoctor)
        let jsonString = String(data: jsonData, encoding: .utf8)!
                print(jsonString)
        guard let data = convertToDictionary(text: jsonString) else{
            return
        }
        let manager = self.sessionManager
        manager.request(urlgetInfo!, method: .get, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"] as? String ?? ""
                if code == 200{
                    do{
                        let dataProduct = try JSONDecoder().decode(AllDoctorApi.self, from: response.data!)
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
    
    func getAllInfoDoctorShow(id: Int,success: @escaping ([DoctorShow]) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetAllDoctorWithHospitalId)
        let param  : Parameters = ["id" : id]
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
                        let dataProduct = try JSONDecoder().decode(AllDoctorWithHospitalApi.self, from: response.data!)
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
    
    func bookAppointment(appointment : Appointment,success: @escaping (Int) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        let urlLogin = URL(string: kAPIBookAppointment)
        
        let jsonData = try! JSONEncoder().encode(appointment)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
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
                    let data = result["data"]  as? Int ?? 0
                    success(data)
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
    
    func getAllAppointmentWithUserID(id: Int,success: @escaping ([AppointmentShow]) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetAllAppointmentWithUserId)
        let param  : Parameters = ["user_id" : id]
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
                        let dataProduct = try JSONDecoder().decode(AllAppointmentShowApi.self, from: response.data!)
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
    
    func getDoctorAppointmentWithID(doctor_id: Int,hospital_id: Int,success: @escaping (DoctorAppoinment) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetDoctorAppointmentWithId)
        let param  : Parameters = ["doctor_id" : doctor_id,"hospital_id" : hospital_id]
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
                        let dataProduct = try JSONDecoder().decode(DoctorAppoinmentAPI.self, from: response.data!)
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
    
    func cancelAppointmentWithID(idAppointment: Int,user_id: Int, doctor_id: Int, success: @escaping (String) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPICancelAppointmentWithId)
        let param  : Parameters = ["idAppointment" : idAppointment,"user_id": user_id,"doctor_id": doctor_id ]
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
                    success(msg)
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
    
    func sendMessage(user_id: Int, message : String,success: @escaping (String) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        let urlLogin = URL(string: kAPISendMessage)
        
        let param  : Parameters = ["user_id": user_id, "message": message ]
        let manager = self.sessionManager
        
        manager.request(urlLogin!, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess{
                guard let result = response.result.value as? Dictionary<String,Any> else{
                    failure( false, kErrorText)
                    return
                }
                
                let code = result["success"] as? Int ?? 0
                let msg = result["msg"]  as? String ?? ""
                if code == 200{
                    print(msg)
                    success(msg )
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
    
    func getAllAppointmentWithDoctorID(doctor_id: Int,success: @escaping ([AppointmentDoctorShow]) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetAllAppointmentOfDoctor)
        let param  : Parameters = ["doctor_id" : doctor_id]
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
                        let dataProduct = try JSONDecoder().decode(AllAppointmentDoctorShowApi.self, from: response.data!)
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
    
    func getAppointmentWithID(id: Int,success: @escaping (AppointmentShow) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void){
        guard Connectivity.isConnectedToInternet()  else {
            failure(false, errorMessageNoInternet)
            return
        }
        
        let urlgetInfo = URL(string: kAPIGetAllAppointmentWithId)
        let param  : Parameters = ["id" : id]
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
                        let dataProduct = try JSONDecoder().decode(AllAppointmentConfirmApi.self, from: response.data!)
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
    
    func caculateGoogleDistance(toPlace: String,success: @escaping (DistanceOrTime) -> Void, failure: @escaping (_ success : Bool , _ messenge : String) -> Void)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let userLocation : CLLocation = appDelegate.userLocation{
            let urlRequest = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)&destinations=\(toPlace)&key=AIzaSyDXpMQJz5_eWu5dOXt4u8_TL_-6cAzwI5A"
            //            print(urlRequest as Any)
             let base_url = urlRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let manager = self.sessionManager
            let headers: HTTPHeaders = [ "Accept": "application/json", "Content-Type": "application/json" ]
            let urlgetInfo = URL(string: base_url)
            manager.request(urlgetInfo!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseString { response in
                
                guard response.result.isSuccess else {
                    failure(false, "Không thể lấy được vị trí")
                    return
                }
                do {
                    let json = try JSON(data: response.data!)
                    let json1 = json["rows"]
                    let json2 = json1[0]
                    let json3 = json2["elements"]
                    let dic = json3[0]
                    
                    let Response = try JSONDecoder().decode(JSON_Distance.self, from: response.data!)
                    success(Response.rows[0].elements[0].distance)
                    print(Response)
                }
                catch let err {
                    print(err.localizedDescription)
                    failure(false, "Không thể lấy được vị trí")
                }
            }
        }
    }
}
