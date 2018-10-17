//
//  Appointment.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/17/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

//struct AllInfoBookAppointmentApi : Codable {
//    let success : Int?
//    let msg : String?
//    let data : InfoBookAppointment?
//}

//struct  Appointment : Codable {
//    var  : [Info]?
//    var chuyenkhoa : [Info]?
//    var hocham : [Info]?
//    var gioitinh : [Info]?
//}
//
//struct Info : Codable {
//    var id : Int?
//    var name : String?
//}

struct Appointment: Codable{
    var id : Int?
    var user_id: Int?
    var doctor_id: Int?
    var hospital_id: Int?
    var dateBook: String?
    var timeBook: String?
    var problem : String?
    var fee: Int?
}
