//
//  RegisterViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfRepass: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    @IBOutlet weak var lblDangnhap: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var userinfo : UserObject?
    var isChangeInfo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isChangeInfo{
            setUpChangeInfo()
        }else{
            setupNotChange()
        }
    }
    
    func setUpChangeInfo(){
        lblDangnhap.isHidden = true
        lblTitle.text = "Cập nhật thông tin"
        self.tabBarController?.tabBar.isHidden = true
        
        if let userData = defaultLogin.data(forKey: kUserDefaultkeyLogin), let user = try?JSONDecoder().decode(UserObject.self, from: userData) {
            userinfo = user
            tfFullName.text = user.name
            tfEmail.text = user.email
            tfPhone.text = user.phone_number
            tfPass.text = user.password
            tfRepass.text = user.password
            tfAddress.text = user.address
        }else{
            setupNotChange()
        }
    }
    
    func setupNotChange(){
        lblDangnhap.isHidden = false
        lblTitle.text = "Đăng ký tài khoản"
        tfFullName.text = ""
        tfEmail.text = ""
        tfPhone.text = ""
        tfPass.text = ""
        tfRepass.text = ""
        tfAddress.text = ""
    }
    
    @IBAction func actionNext(_ sender: Any) {
        
        guard tfFullName.text != "" && tfEmail.text != "" && tfPhone.text != "" && tfPass.text != "" && tfRepass.text != "" && tfAddress.text != "" else{
            MDProvider.loadAlert(title: "", message: errMissInfoRegister)
            return
        }
        
        if !(tfEmail.text?.isEmail)!{
            MDProvider.loadAlert(title: "", message: errWrongEmailFormat)
            return
        }
        
        if !(tfPhone.text?.isNumber)!{
            MDProvider.loadAlert(title: "", message: errWrongPhoneNumberFormat)
            return
        }
        
        if (tfPhone.text?.count)! != 10{
            MDProvider.loadAlert(title: "", message: errWrongPhoneNumberFormat)
            return
        }
        
        if (tfPass.text?.count)! < 8{
            MDProvider.loadAlert(title: "", message: errWrongPassMinLength)
            return
        }
        
        if tfPass.text != tfRepass.text {
            MDProvider.loadAlert(title: "", message: errWrongPassAndRepass)
            return
        }
        
        if isChangeInfo{
            userinfo = UserObject(id: userinfo?.id ?? 0, name: tfFullName.text, email: tfEmail.text, password: tfPass.text, phone_number: tfPhone.text, birthday: userinfo?.birthday ?? "", weight: userinfo?.weight ?? 0, height:  userinfo?.height ?? 0,gender: userinfo?.gender ?? "", doctor_id : userinfo?.doctor_id ?? 0,avatar:  userinfo?.avatar ?? "", address :  userinfo?.address ?? "" )
        }else{
            userinfo = UserObject(id: 0, name: tfFullName.text, email: tfEmail.text, password: tfPass.text, phone_number: tfPhone.text, birthday: "", weight: 0, height: 0,gender: "", doctor_id : 0,avatar: "", address : tfAddress.text )
        }
        
        self.performSegue(withIdentifier: kSegueRegisterToBirthday, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueRegisterToBirthday {
            if let vc = segue.destination as? BirthDayViewController{
                vc.userInfo = userinfo
                vc.isChangeInfo = isChangeInfo
            }
        }
    }
    
    @IBAction func actionback(_ sender: Any) {
        if isChangeInfo{
            self.performSegue(withIdentifier: kSegueRegisterToHomeScreen, sender: nil)
        }else{
            self.performSegue(withIdentifier: kSegueRegisterToLogin, sender: nil)
        }
    }
    
}

