//
//  LoginViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class LoginViewController: MDBaseViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        tfEmail.text = "ducchinh@sdsdf.com"
        tfPass.text = "dsfsdfr"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        if Connectivity.isConnectedToInternet() == false{
            MDProvider.loadAlert(title: "", message:errNoInterNet )
            return
        }
        guard let email = tfEmail.text , email != ""  else {
            MDProvider.loadAlert(title: "", message: errMissInfoLogin)
            return
        }
        
        if email.isEmail == false{
            MDProvider.loadAlert(title: "", message: errWrongEmailFormat)
            return
        }
        
        guard let password = tfPass.text , password != "" else{
            MDProvider.loadAlert(title: "", message: errMissInfoLogin)
            return
        }
        SVProgressHUD.show()
        self.performSegue(withIdentifier: kSegueLoginToTabbar, sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
