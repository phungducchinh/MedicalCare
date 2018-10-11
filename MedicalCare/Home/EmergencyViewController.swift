//
//  EmergencyViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/2/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD

class EmergencyViewController: MDBaseViewController {

    @IBOutlet weak var tbvEmergency: UITableView!
    
    var arrEmergency : [Emergency] = []
    var row = 0
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Cấp cứu khẩn cấp"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvEmergency.estimatedRowHeight = 80
        tbvEmergency.rowHeight = UITableViewAutomaticDimension
        DispatchQueue.main.async {
            self.getData()
        }
    }

    func getData(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllEmergency(success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.arrEmergency = success
            self.tbvEmergency.reloadData()
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension EmergencyViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmergency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorHospitalCell", for: indexPath) as! DoctorHospitalCell
        let info = arrEmergency[indexPath.row]
        cell.setupEmergencyCell(name: info.name ?? "", address: info.phone_number ?? "", phone: info.phone_number ?? "")
        return cell
    }
    
    
}
