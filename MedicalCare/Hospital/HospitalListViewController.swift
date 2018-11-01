//
//  HospitalListViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/29/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD
class HospitalListViewController: MDBaseViewController {

    @IBOutlet weak var tbvListHospital: UITableView!
    
    let hud = JGProgressHUD(style: .dark)
    var arrHospital : [Hospital] = []
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MDProvider.instance.setUpNavigation(controller: self)
        self.navigationItem.title = "Danh sách bệnh viện"
        tbvListHospital.estimatedRowHeight = 80
        tbvListHospital.rowHeight = UITableViewAutomaticDimension
        DispatchQueue.main.async {
            self.getAllHospital()
        }
    }
    
    func getAllHospital(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllHospital(url: kAPIGetAllHospital, idquest: 0, success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.arrHospital = success
            self.tbvListHospital.reloadData()
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueHospitalToDetail{
            if let vc = segue.destination as? HospitalPharmacyDetialViewController{
                vc.infoHospital = self.arrHospital[row]
                vc.navigationItem.title = "Thông tin bệnh viện"
            }
        }
    }

}

extension HospitalListViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHospital.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
        let info = self.arrHospital[indexPath.row]
        cell.setUpCell(strAva: info.avatar ?? "" , name: info.name ?? "", special: "", hospital: info.address ?? "", addHos: info.address ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.row = indexPath.row
        self.performSegue(withIdentifier: kSegueHospitalToDetail, sender: self)
    }
}
