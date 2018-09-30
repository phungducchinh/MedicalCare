//
//  ProfileRegiterViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProfileRegiterViewController: UIViewController {

    @IBOutlet weak var pickerUserInfo: UIPickerView!
    
    var userInfo : UserObject?
    
    var pickerData: [[Any]] = [[Any]]()
    
    var arrWeight = [Int]()
    var arrHeight = [Int]()
    var arrGender = ["Nam", "Nữ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        for i in 0...250{
            arrHeight.append(i)
            arrWeight.append(i)
        }
        
        pickerData = [arrWeight, arrHeight, arrGender]
        pickerUserInfo.selectRow(50, inComponent: 0, animated: true)
        pickerUserInfo.selectRow(150, inComponent: 1, animated: true)
        
        MDProvider.instance.setShadown(view: pickerUserInfo, borderShadow: 2.0, bgColor :.white, shadownColor : .black)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        // action call api register
        self.performSegue(withIdentifier: kSegueRegisterToTabbar, sender: nil)
    }
}

extension ProfileRegiterViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ("\(pickerData[component][row])")
    }
    
    /* set color for text in title
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = ("\(pickerData[component][row])")
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.foregroundColor: clTextTitle])

        return myTitle
     }*/
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            userInfo?.height = arrHeight[row]
        case 1:
            userInfo?.weight = arrWeight[row]
        case 2:
            if arrGender[row] == "Nam"{
                userInfo?.gender = true
            }else{
                userInfo?.gender = false
            }
        default:
            print(component as Any)
        }
    }

}
