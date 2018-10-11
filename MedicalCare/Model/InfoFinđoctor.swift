//
//  InfoFinđoctor.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/11/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

struct AllInfofindDoctorApi : Codable {
    let success : Int?
    let msg : String?
    let data : InfofindDoctor?
}

struct  InfofindDoctor : Codable {
    var benhvien : [Info]?
    var chuyenkhoa : [Info]?
    var hocham : [Info]?
    var gioitinh : [Info]?
}

struct Info : Codable {
    var id : Int?
    var name : String?
}
