//
//  EmergencyViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/2/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class EmergencyViewController: MDBaseViewController {

    @IBOutlet weak var tbvEmergency: UITableView!
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorHospitalCell", for: indexPath) as! DoctorHospitalCell
        return cell
    }
    
    
}
