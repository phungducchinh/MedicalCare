//
//  Doctor.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/12/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

struct AllDoctorApi : Codable {
    let success : Int?
    let msg : String?
    let data : [Doctor]?
}

struct  Doctor : Codable {
    var id : Int?
    var name : String?
    var specialize : String?
    var address : String?
    var phone_number : String?
    var info_about : String?
    var certificate : [Info]?
    var type_time: Int?
    var avatar: String?
}

struct AllDoctorWithHospitalApi: Codable{
    let success : Int?
    let msg : String?
    let data : [DoctorShow]?
}

struct DoctorShow: Codable {
    var id : Int?
    var name : String?
    var type_time : Int?
    var fee: Int?
    var list_time : [String]?
}

