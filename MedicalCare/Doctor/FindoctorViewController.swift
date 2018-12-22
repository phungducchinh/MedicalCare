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
    
    var arrHospital: [String] = ["Chọn bệnh viện"]
    var arrSpecialize: [String] = ["Chọn chuyên khoa"]
    var arrCertificate: [String] = ["Chọn học hàm"]
    var arrGender: [String] = ["Chọn giới tính"]
    
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
    
    func getData(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllInfoFindDoctor(success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.infoFindDoctor = success
            self.arrHospital.removeAll()
            self.arrHospital = ["Chọn bệnh viện"]
            self.arrSpecialize = ["Chọn chuyên khoa"]
            self.arrCertificate = ["Chọn học hàm"]
            self.arrGender = ["Chọn giới tính"]
            if (self.infoFindDoctor?.benhvien) != nil {
                self.arrHospital += self.cnvArrInfoToArrString(arrFrom: (self.infoFindDoctor?.benhvien)!)
            }
            if (self.infoFindDoctor?.chuyenkhoa) != nil {
                self.arrSpecialize += self.cnvArrInfoToArrString(arrFrom: (self.infoFindDoctor?.chuyenkhoa)!)
            }
            if (self.infoFindDoctor?.hocham) != nil {
                self.arrCertificate += self.cnvArrInfoToArrString(arrFrom: (self.infoFindDoctor?.hocham)!)
            }
            if (self.infoFindDoctor?.gioitinh) != nil {
                self.arrGender += self.cnvArrInfoToArrString(arrFrom: (self.infoFindDoctor?.gioitinh)!)
            }
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    
    func cnvArrInfoToArrString(arrFrom : [Info]) -> [String]{
        var arrStr = [""]
        arrStr.removeAll()
        for i in arrFrom{
            arrStr.append(i.name ?? "")
        }
        return arrStr
    }
    
    func getId(info: [Info], name: String) -> Int{
        var id = 0
        for i in info{
            if i.name == name{
                id = i.id ?? 0
            }
        }
        return id
    }
    
    func getGender(gender: String) -> String{
        let gder = ""
        if arrGender.count > 0{
            if getId(info: (infoFindDoctor?.gioitinh)!, name: gender) == 0{
                return gder
            }else{
                return gender
            }
        }else{
            return gder
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acChooseHospital(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arrHospital, controller: self, idButton: 0)
    }
    @IBAction func acChooseSpecialize(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arrSpecialize, controller: self, idButton: 1)
    }
    @IBAction func acChooseCertificate(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arrCertificate, controller: self, idButton: 2)
    }
    @IBAction func acChooseGender(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource:  arrGender, controller: self, idButton: 3)
    }
    
    @IBAction func actionFindDoctor(_ sender: Any) {
        self.performSegue(withIdentifier: kSegueFindDoctorToListDoctor, sender: self)
    }

    func clearData(){
        btnHospital.setTitle(arrHospital[0], for: .normal)
        btnSpecialize.setTitle(arrSpecialize[0], for: .normal)
        btnCertificate.setTitle(arrCertificate[0], for: .normal)
        btnGender.setTitle(arrGender[0], for: .normal)
        MDProvider.instance.changeClTextBtn(btn: btnHospital, index: 0)
        MDProvider.instance.changeClTextBtn(btn: btnSpecialize, index: 0)
        MDProvider.instance.changeClTextBtn(btn: btnCertificate, index: 0)
        MDProvider.instance.changeClTextBtn(btn: btnGender, index: 0)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueFindDoctorToListDoctor{
            let find = FindDoctor(hospital_id: getId(info: (infoFindDoctor?.benhvien)!, name: btnHospital.titleLabel?.text ?? "") , certificate_id: getId(info: (infoFindDoctor?.hocham)!, name: btnCertificate.titleLabel?.text ?? "") ,
                                  specialize_id: getId(info: (infoFindDoctor?.chuyenkhoa)!, name: btnSpecialize.titleLabel?.text ?? "") ,
                                  gender: getGender(gender: btnGender.titleLabel?.text ?? "") )
            let vc = segue.destination as? DoctorListViewController
                vc?.objFindDoctor = find
        }
    }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clearData()
    }
}

extension FindoctorViewController : DropDownDelegate{
    func getValueIndropDown(index: Int, idIndex: Int) {
        switch idIndex {
        case 0:
            btnHospital.setTitle(arrHospital[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnHospital, index: index)
        case 1:
            btnSpecialize.setTitle(arrSpecialize[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnSpecialize, index: index)
        case 2:
            btnCertificate.setTitle(arrCertificate[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnCertificate, index: index)
        case 3:
            btnGender.setTitle(arrGender[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnGender, index: index)
        default:
            print("choose " , index , "on button ", idIndex)
        }
    }
    
    
}
