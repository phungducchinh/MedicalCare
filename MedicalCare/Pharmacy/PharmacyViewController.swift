//
//  PharmacyViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/29/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class PharmacyViewController: MDBaseViewController {

    @IBOutlet weak var tbvListPharmacy: UITableView!
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSeguePharmacyToDetail{
            if let vc = segue.destination as? HospitalPharmacyDetialViewController{
                vc.navigationItem.title = "Thông tin nhà thuốc"
            }
        }
    }

}

extension PharmacyViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kSeguePharmacyToDetail, sender: self)
    }
}
