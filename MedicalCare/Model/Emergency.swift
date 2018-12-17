//
//  Emergency.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/11/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation 
import UIKit

struct AllEmergencyApi : Codable {
    let success : Int?
    let msg : String?
    let data : [Emergency]?
}

struct  Emergency : Codable {
    var id : Int?
    var name : String?
    var phone_number : String?
    var hospital_id : Int?
}
