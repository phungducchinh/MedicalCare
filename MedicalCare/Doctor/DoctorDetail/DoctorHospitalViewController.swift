//
//  DoctorHospitalViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/26/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD

class DoctorHospitalViewController: MDBaseViewController {

    @IBOutlet weak var tbvDoctorHospital: UITableView!
    
    let arrName = ["Jym Hospital","Apex Hospital", "Safe Zone Hospital"]
    let arrAddress = ["Plot no 5, Atharv nagar,Ring road, Nagpur", "Plot no 5, Atharv nagar,Ring road, Nagpur" , "Plot no 5, Atharv nagar,Ring road, Nagpur"]
    var objDoctor : Doctor?
    var arrHospital : [Hospital] = []
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()

        if tbvDoctorHospital.contentSize.height > tbvDoctorHospital.frame.height{
            tbvDoctorHospital.isScrollEnabled = true
        }else{
            tbvDoctorHospital.isScrollEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Thông tin nơi công tác"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvDoctorHospital.estimatedRowHeight = 80
        tbvDoctorHospital.rowHeight = UITableViewAutomaticDimension
        tbvDoctorHospital.separatorStyle = .none
        DispatchQueue.main.async {
            self.getData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllHospital(url: kAPIGetAllHospitalWithDoctorId, success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.arrHospital = success
            self.tbvDoctorHospital.reloadData()
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
}

extension DoctorHospitalViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return arrHospital.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
            cell.lblName.text = objDoctor?.name ?? ""
            cell.lblSpecallize.text = objDoctor?.specialize ?? ""
            MDProvider.instance.setupImage(strAva: objDoctor?.avatar ?? "", imgView: cell.imgAvatar)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorHospitalCell", for: indexPath) as! DoctorHospitalCell
            if arrHospital.count > indexPath.row{
                let info = arrHospital[indexPath.row]
                cell.setupEmergencyCell(name: info.name ?? "", address: info.address ?? "", phone: info.phone_number ?? "")
            }
            return cell
        }
    }
    
    
}
