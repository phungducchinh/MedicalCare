//
//  User.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

struct  UserObject : Decodable {
    var id : Int?
    var name : String?
    var email : String?
    var password : String?
    var phonenumber : String?
    var birthday : String?
    var weight : Int?
    var height : Int?
    var gender : Bool?
    var avatar : String?
}
