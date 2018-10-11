//
//  Hospital.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/11/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

struct AllHospitalApi : Codable {
    let success : Int?
    let msg : String?
    let data : [Hospital]?
}

struct  Hospital : Codable {
    var id : Int?
    var name : String?
    var phone_number : String?
    var info : String?
    var avatar : String?
    var address : String?
}
