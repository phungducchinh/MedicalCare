//
//  FindoctorViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/24/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class FindoctorViewController: MDBaseViewController {

    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnSpecialize: UIButton!
    @IBOutlet weak var btnCertificate: UIButton!
    @IBOutlet weak var btnGender: UIButton!
    
    let arr = ["Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B" , "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Tìm bác sĩ"
        MDProvider.instance.setUpNavigation(controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acChooseHospital(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arr, controller: self, idButton: 0)
    }
    @IBAction func acChooseSpecialize(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arr, controller: self, idButton: 1)
    }
    @IBAction func acChoosêCrtificate(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arr, controller: self, idButton: 2)
    }
    @IBAction func acChooseGender(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arr, controller: self, idButton: 3)
    }
    
    @IBAction func actionFindDoctor(_ sender: Any) {
        self.performSegue(withIdentifier: kSegueFindDoctorToListDoctor, sender: nil)
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

extension FindoctorViewController : DropDownDelegate{
    func getValueIndropDown(index: Int, idIndex: Int) {
        switch idIndex {
        case 0:
            btnHospital.setTitle(arr[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnHospital, index: index)
        case 1:
            btnSpecialize.setTitle(arr[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnSpecialize, index: index)
        case 2:
            btnCertificate.setTitle(arr[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnCertificate, index: index)
        case 3:
            btnGender.setTitle(arr[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnGender, index: index)
        default:
            print("choose " , index , "on button ", idIndex)
        }
    }
    
    
}
