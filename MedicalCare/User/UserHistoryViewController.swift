//
//  UserHistoryViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class UserHistoryViewController: MDBaseViewController {

    @IBOutlet weak var tbvListAppointment: UITableView!
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
        self.navigationItem.title = "Lịch sử cuộc hẹn"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvListAppointment.estimatedRowHeight = 80
        tbvListAppointment.rowHeight = UITableViewAutomaticDimension
        tbvListAppointment.separatorStyle = .none
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
extension UserHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDetailViewCell", for: indexPath) as! AppointmentDetailViewCell
        return cell
    }
}
