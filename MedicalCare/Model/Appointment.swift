//
//  Appointment.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/17/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

struct AllAppointmentApi : Codable {
    let success : Int?
    let msg : String?
    let data : [Appointment]?
}

struct Appointment: Codable{
    var id : Int?
    var user_id: Int?
    var doctor_id: Int?
    var hospital_id: Int?
    var dateBook: String?
    var timeBook: String?
    var problem : String?
    var fee: Int?
    var status: Int?
}

struct AllAppointmentShowApi : Codable {
    let success : Int?
    let msg : String?
    let data : [AppointmentShow]?
}

struct AppointmentShow: Codable{
    var id : Int?
    var user_id: Int?
    var doctor_id: Int?
    var hospital_id: Int?
    var dateBook: String?
    var timeBook: String?
    var problem : String?
    var fee: Int?
    var status: Int?
    var doctor: DoctorAppoinment?
}

struct AllAppointmentDoctorShowApi : Codable {
    let success : Int?
    let msg : String?
    let data : [AppointmentDoctorShow]?
}

struct AppointmentDoctorShow: Codable{
    var id : Int?
    var user_id: Int?
    var doctor_id: Int?
    var hospital_id: Int?
    var dateBook: String?
    var timeBook: String?
    var problem : String?
    var fee: Int?
    var status: Int?
    var user_name: String?
    var doctor: DoctorAppoinmentShow?
}

struct DoctorAppoinmentShow: Codable{
    var id : Int?
    var doctor_name : String?
    var specialize : String?
    var hospital : String?
}

struct AllAppointmentConfirmApi : Codable {
    let success : Int?
    let msg : String?
    let data : AppointmentShow?
}

