//
//  PharmacyViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/29/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD
class PharmacyViewController: MDBaseViewController {

    @IBOutlet weak var tbvListPharmacy: UITableView!
    let hud = JGProgressHUD(style: .dark)
    var arrHospital : [Hospital] = []
    var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Danh sách nhà thuốc"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvListPharmacy.estimatedRowHeight = 80
        tbvListPharmacy.rowHeight = UITableViewAutomaticDimension
        DispatchQueue.main.async {
            self.getAllHospital()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllHospital(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllHospital(url: kAPIGetAllPharmacy, success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.arrHospital = success
            self.tbvListPharmacy.reloadData()
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSeguePharmacyToDetail{
            if let vc = segue.destination as? HospitalPharmacyDetialViewController{
                vc.infoHospital = arrHospital[row]
                vc.navigationItem.title = "Thông tin nhà thuốc"
            }
        }
    }

}

extension PharmacyViewController : UITableViewDataSource, UITableViewDelegate{
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
        self.performSegue(withIdentifier: kSeguePharmacyToDetail, sender: self)
    }
}
