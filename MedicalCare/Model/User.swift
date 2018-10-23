//
//  User.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

struct UserApi : Codable {
    let success : Int?
    let msg : String?
    let data : UserObject?
}

struct  UserObject : Codable {
    var id : Int?
    var name : String?
    var email : String?
    var password : String?
    var phone_number : String?
    var birthday : String?
    var weight : Int?
    var height : Int?
    var gender : String?
    var doctor_id : Int?
    var avatar : String?
    var address : String?
    
}

struct UserLoginInfo : Encodable{
    var email : String?
    var password : String?
}
