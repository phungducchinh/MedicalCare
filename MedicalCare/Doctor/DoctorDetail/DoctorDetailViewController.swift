//
//  DoctorDetailViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/25/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class DoctorDetailViewController: MDBaseViewController {
    @IBOutlet weak var tbvDoctorInfo: UITableView!
    let arrTitle = ["Địa chỉ và thời gian làm việc","Chứng chỉ"]
    var objDoctor : Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tbvDoctorInfo.contentSize.height > tbvDoctorInfo.frame.height{
            tbvDoctorInfo.isScrollEnabled = true
        }else{
            tbvDoctorInfo.isScrollEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Thông tin bác sĩ"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvDoctorInfo.estimatedRowHeight = 80
        tbvDoctorInfo.rowHeight = UITableViewAutomaticDimension
        tbvDoctorInfo.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cnvArrInfoToArrString(arrFrom : [Info]) -> [String]{
        var arrStr = [""]
        arrStr.removeAll()
        for i in arrFrom{
            arrStr.append(i.name ?? "")
        }
        return arrStr
    }
}

extension DoctorDetailViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
            cell.lblName.text = objDoctor?.name ?? ""
            cell.lblSpecallize.text = objDoctor?.specialize ?? ""
            MDProvider.instance.setupImage(strAva: objDoctor?.avatar ?? "", imgView: cell.imgAvatar)
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell", for: indexPath) as! DoctorInfoCell
            cell.lblTitle.text = "Mô tả"
            cell.tfInfo.text = objDoctor?.info_about ?? ""
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoWithImageCell", for: indexPath) as! DoctorInfoWithImageCell
            if indexPath.row == 0{
                var time = ""
                if objDoctor?.type_time ?? 0 == 0{
                    time = "7:30 đến 11:30 Thứ 2 đến thứ 7"
                }else{
                    time = "13:30 đến 17:30 Thứ 2 đến thứ 7"
                }
                cell.setupData(title: arrTitle[indexPath.row], address: objDoctor?.address ?? "", time:time)
            }else if indexPath.row == 1{
                var arrCertificate  = [""]
                cell.lblTitle.text = arrTitle[indexPath.row]
                if let arrCer = objDoctor?.certificate {
                    arrCertificate = cnvArrInfoToArrString(arrFrom: arrCer)
                }
                cell.setupNotImage(arrInfo: arrCertificate)
            }
            return cell
        }
    }
    
    
}
