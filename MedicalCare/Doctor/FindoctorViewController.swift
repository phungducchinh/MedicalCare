//
//  FindoctorViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/24/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD
class FindoctorViewController: MDBaseViewController {

    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnSpecialize: UIButton!
    @IBOutlet weak var btnCertificate: UIButton!
    @IBOutlet weak var btnGender: UIButton!
    
//    let arr = ["Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B" , "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B"]
    
    var infoFindDoctor : InfofindDoctor?
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Tìm bác sĩ"
        MDProvider.instance.setUpNavigation(controller: self)
        DispatchQueue.main.async {
            self.getData()
        }
    }
    
    func cnvArrInfoToArrString(arrFrom : [Info], temp : String) -> [String]{
        var arrStr = [""]
        arrStr.removeAll()
        let normal = Info.init(id: 0, name: temp)
        var arrtemp = arrFrom
        arrtemp.removeAll()
        arrtemp.append(normal)
        arrtemp += arrFrom
        for i in arrtemp{
            arrStr.append(i.name ?? "")
        }
        return arrStr
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acChooseHospital(_ sender: Any) {
        guard let arrHospital = infoFindDoctor?.benhvien else{
            MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: ["Chọn bệnh viện"], controller: self, idButton: 0)
            return
        }
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: self.cnvArrInfoToArrString(arrFrom: arrHospital, temp: "Chọn bệnh viện"), controller: self, idButton: 0)
    }
    @IBAction func acChooseSpecialize(_ sender: Any) {
        guard let arrPecialize = infoFindDoctor?.chuyenkhoa else{
            MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: ["Chọn chuyên khoa"], controller: self, idButton: 0)
            return
        }
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: self.cnvArrInfoToArrString(arrFrom: arrPecialize, temp: "Chọn chuyên khoa"), controller: self, idButton: 1)
    }
    @IBAction func acChooseCertificate(_ sender: Any) {
        guard let arrCertificate = infoFindDoctor?.hocham else{
            MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: ["Chọn học hàm"], controller: self, idButton: 0)
            return
        }
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: self.cnvArrInfoToArrString(arrFrom: arrCertificate, temp: "Chọn học hàm"), controller: self, idButton: 2)
    }
    @IBAction func acChooseGender(_ sender: Any) {
        guard let arrGender = infoFindDoctor?.gioitinh else{
            MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: ["Chọn giới tính"], controller: self, idButton: 0)
            return
        }
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource:  self.cnvArrInfoToArrString(arrFrom: arrGender, temp: "Chọn giới tính"), controller: self, idButton: 3)
    }
    
    @IBAction func actionFindDoctor(_ sender: Any) {
        self.performSegue(withIdentifier: kSegueFindDoctorToListDoctor, sender: nil)
    }
    
    func getData(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllInfoFindDoctor(success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.infoFindDoctor = success
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
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
            guard let arrHospital = infoFindDoctor?.benhvien else{
                btnHospital.setTitle("Chọn bệnh viện", for: .normal)
                MDProvider.instance.changeClTextBtn(btn: btnHospital, index: index)
                return
            }
            btnHospital.setTitle(self.cnvArrInfoToArrString(arrFrom: arrHospital, temp: "Chọn bệnh viện")[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnHospital, index: index)
        case 1:
            guard let arrSpecialize = infoFindDoctor?.chuyenkhoa else{
                btnHospital.setTitle("Chọn chyên khoa", for: .normal)
                MDProvider.instance.changeClTextBtn(btn: btnSpecialize, index: index)
                return
            }
            btnSpecialize.setTitle(self.cnvArrInfoToArrString(arrFrom: arrSpecialize, temp: "Chọn chuyên khoa")[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnSpecialize, index: index)
        case 2:
            guard let arrCertificate = infoFindDoctor?.hocham else{
                btnHospital.setTitle("Chọn học hàm", for: .normal)
                MDProvider.instance.changeClTextBtn(btn: btnCertificate, index: index)
                return
            }
            btnCertificate.setTitle(self.cnvArrInfoToArrString(arrFrom: arrCertificate, temp: "Chọn học hàm")[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnCertificate, index: index)
        case 3:
            guard let arrGender = infoFindDoctor?.gioitinh else{
                btnHospital.setTitle("Chọn giới tính", for: .normal)
                MDProvider.instance.changeClTextBtn(btn: btnGender, index: index)
                return
            }
            btnGender.setTitle(self.cnvArrInfoToArrString(arrFrom: arrGender, temp: "Chọn giới tính")[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnGender, index: index)
        default:
            print("choose " , index , "on button ", idIndex)
        }
    }
    
    
}
