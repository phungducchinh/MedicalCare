//
//  HospitalListViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/29/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class HospitalListViewController: MDBaseViewController {

    @IBOutlet weak var tbvListHospital: UITableView!
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueHospitalToDetail{
            if let vc = segue.destination as? HospitalPharmacyDetialViewController{
                vc.navigationItem.title = "Thông tin bệnh viện"
            }
        }
    }

}

extension HospitalListViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kSegueHospitalToDetail, sender: self)
    }
}
