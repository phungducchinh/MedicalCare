//
//  Contants.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit


//-----------Color-----
let clTextTitle = UIColor(red: 25/255, green: 115/255, blue: 159/255, alpha: 1)
let clShadownBlue = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 0.17)
let clDark = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
let clGreenGardient = UIColor(red: 53/255, green: 216/255, blue: 166/255, alpha: 1)

//-----------Segue text ----
let kSegueHomeToFindDoctor = "homeToFindDoctor"
let kSegueHomeToListHospital = "HomeToListHospital"
let kSegueHomeToListPharmarcy = "HomeToListPharmarcy"
let kSegueMakeToCfAppointment = "MakeToConfirmAppointment"
let kSegueLoginToTabbar = "loginToTabbar"
let kSegueFindDoctorToListDoctor = "FindDoctorToListDoctor"
let kSegueDoctorToDoctorInfo = "DoctorToDoctorInfo"
let kSegueDoctorToDoctorHospital = "DoctorToDoctorHospital"
let kSegueRegisterToBirthday = "RegisterToBirthday"
let kSegueBirthdayToWeight = "BirthdayToWeight"
let kSegueRegisterToTabbar = "RegisterToTabbar"
let kSegueHomeToHistory = "HomeToHistory"
let kSegueUserToListAppointment = "UserToListAppointment"
let kSegueUserToLogin = "UserToLogin"

//------------Error text ----
let errNoInterNet = "Không có kết nối internet.\nVui lòng thử lại."
let errWrongEmailFormat = "Định dạng email không đúng.\nVui lòng nhập lại."
let errWrongInfoLogin = "Thông tin đăng nhập không đúng.\nVui lòng nhập lại."
let errMissInfoLogin = "Thiếu thông tin đăng nhập.\nVui lòng nhập lại."
let errMissInfoRegister = "Thiếu thông tin đăng ký.\nVui lòng nhập lại."
let errWrongPhoneNumberFormat = "Định dạng số điện thoại không đúng.\nVui lòng nhập lại."
let errWrongPassAndRepass = "Mật khẩu không khớp.\nVui lòng nhập lại."
let errWrongAddress = "Không thể mở bản đồ.\nVui lòng thử lại"
