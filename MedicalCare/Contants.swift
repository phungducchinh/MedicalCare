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
let clDarkTex = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
let clGreenGardient = UIColor(red: 53/255, green: 216/255, blue: 166/255, alpha: 1)
let clProgressbar = UIColor(red: 95/255, green: 229/255, blue: 188/255, alpha: 1)

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
let kSegueHospitalToDetail = "HospitalToDetail"
let kSeguePharmacyToDetail = "PharmacyToDetail"
let kSegueUserToUpdateInfo = "UserToUpdateInfo"
let kSegueHomeToEmergency = "HomeToEmergency"
let kSegueRegisterToLogin = "RegisterToLogin"
let kSegueRegisterToHomeScreen = "RegisterToHomeScreen"
let kSegueUserToMessengerView = "UserToMessengerView"
let kSegueUserToHealthView = "UserInfoToHealthInfo"

//------------Error text ----
let errNoInterNet = "Không có kết nối internet.\nVui lòng thử lại."
let errWrongEmailFormat = "Định dạng email không đúng.\nVui lòng nhập lại."
let errWrongInfoLogin = "Thông tin đăng nhập không đúng.\nVui lòng nhập lại."
let errMissInfoLogin = "Thiếu thông tin đăng nhập.\nVui lòng nhập lại."
let errMissInfoRegister = "Thiếu thông tin đăng ký.\nVui lòng nhập lại."
let errWrongPhoneNumberFormat = "Số điện thoại không đúng.\nVui lòng nhập lại."
let errWrongPassMinLength = "Mật khẩu ít nhất 8 ký tự.\nVui lòng nhập lại"
let errWrongPassAndRepass = "Mật khẩu không khớp.\nVui lòng nhập lại."
let errWrongAddress = "Không thể mở bản đồ.\nVui lòng thử lại"

let errorMessageNoInternet = "Không thể kết nối internet.\nVui lòng kiểm tra và thử lại."
let kErrorTimeOutText = "Time out when call api"
let kErrorText = "Xảy ra lỗi trong quá trình kết nối database.\nVui lòng thử lại."
let errorFailLogin = "Đăng nhập không thành công!\nVui lòng thử lại."
let errorFailRegister = "Đăng ký không thành công.\nVui lòng thử lại."
let errorMissInfoBookAppointment = "Thiếu thông tin đăng ký lịch khám.\nVui lòng thử lại."
let errorMissInfoSendMessage = "Vui lòng điền nội dung tin nhắn muốn gửi đi."
let errorCancelAppointment = "Không thể huỷ lịch hẹn!\nVui lòng huỷ lịch hẹn trước ít nhất 1 ngày"

//---------Api doucument-----
//let kServerDomain = "http://192.168.1.158:8080/medicalcare/" //local server tokyo
let kServerDomain = "http://192.168.35.25:8080/medicalcare/" //local server home
//let kServerDomain = "http://172.16.1.129:8080/medicalcare/" //local server the coffe house

let kAPILogin = kServerDomain + "login.php"
let kAPIGetUserInfo = kServerDomain + "getUserInfo.php"
let kAPIRegister = kServerDomain + "registerUser.php"
let kAPIGetAllHospital = kServerDomain + "getAllHospital.php"
let kAPIGetAllPharmacy = kServerDomain + "getAllMedicalShop.php"
let kAPIGetAllEmergency = kServerDomain + "getAllEmergency.php"
let kAPIGetAllInfoFindDoctor = kServerDomain + "getAllInfoFindDoctor.php"
let kAPIGetAllInfoDoctor = kServerDomain + "getDoctor.php"
let kAPIGetAllHospitalWithDoctorId = kServerDomain + "getHospitalWithDoctor.php"
let kAPIGetAllDoctorWithHospitalId = kServerDomain + "getDoctorWithHospital.php"
let kAPIBookAppointment = kServerDomain + "bookAppointment.php"
let kAPIGetAllAppointmentWithUserId = kServerDomain + "getAllAppointment.php"
let kAPIGetDoctorAppointmentWithId = kServerDomain + "getDoctorWithID.php"
let kAPICancelAppointmentWithId = kServerDomain + "deleteAppointment.php"
let kAPIUpdateUserInfo = kServerDomain + "updateInfoUser.php"
let kAPISendMessage = kServerDomain + "sendMessage.php"
let kAPIGetAllAppointmentOfDoctor = kServerDomain + "getAllAppointmentDoctor.php"
let kAPIGetAllAppointmentWithId = kServerDomain + "getAppointmentWithId.php"


//---------Key ----------
var defaultLogin = UserDefaults.standard
let kUserDefaultkeyLogin = "loginname"

//---------Number---------
let MESSAGE_LIMIT = 500
