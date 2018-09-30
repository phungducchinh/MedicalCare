//
//  DoctorHospitalViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/26/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class DoctorHospitalViewController: MDBaseViewController {

    @IBOutlet weak var tbvDoctorHospital: UITableView!
    
    let arrName = ["Jym Hospital","Apex Hospital", "Safe Zone Hospital"]
    let arrAddress = ["Plot no 5, Atharv nagar,Ring road, Nagpur", "Plot no 5, Atharv nagar,Ring road, Nagpur" , "Plot no 5, Atharv nagar,Ring road, Nagpur"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Thông tin nơi công tác"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvDoctorHospital.estimatedRowHeight = 80
        tbvDoctorHospital.rowHeight = UITableViewAutomaticDimension
        tbvDoctorHospital.separatorStyle = .none
        if tbvDoctorHospital.contentSize.height > tbvDoctorHospital.frame.height{
            tbvDoctorHospital.isScrollEnabled = true
        }else{
            tbvDoctorHospital.isScrollEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return arrName.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorHospitalCell", for: indexPath) as! DoctorHospitalCell
            cell.idCell = indexPath.row
            return cell
        }
    }
    
    
}
