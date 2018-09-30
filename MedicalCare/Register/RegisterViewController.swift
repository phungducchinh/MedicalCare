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
    
    var userinfo : UserObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tfFullName.text = "Nguyen van a"
        tfEmail.text = "nguyenvana@gmail.com"
        tfPhone.text = "0876522232"
        tfPass.text = "12345678"
        tfPass.text = "12345678"
        tfRepass.text = "12345678"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionNext(_ sender: Any) {
        
        guard tfFullName.text != "" && tfEmail.text != "" && tfPhone.text != "" && tfPass.text != "" && tfRepass.text != "" else{
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
        
        if tfPass.text != tfRepass.text {
            MDProvider.loadAlert(title: "", message: errWrongPassAndRepass)
            return
        }
        
        userinfo = UserObject(id: 0, name: tfFullName.text, email: tfEmail.text, password: tfPass.text, phonenumber: tfPhone.text, birthday: "", weight: 0, height: 0, gender: true, avatar: "")
    
        self.performSegue(withIdentifier: kSegueRegisterToBirthday, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueRegisterToBirthday {
            if let vc = segue.destination as? BirthDayViewController{
                vc.userInfo = userinfo
            }
        }
    }

}
