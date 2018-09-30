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
        self.navigationItem.title = "Danh sách nhà thuốc"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvListPharmacy.estimatedRowHeight = 80
        tbvListPharmacy.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
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

extension PharmacyViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
        return cell
    }
    
    
}
