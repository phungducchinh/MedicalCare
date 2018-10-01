//
//  HistoryViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class HistoryViewController: MDBaseViewController {

    @IBOutlet weak var tvListAppointment: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tvListAppointment.estimatedRowHeight = 80
        tvListAppointment.rowHeight = UITableViewAutomaticDimension
        tvListAppointment.separatorStyle = .none
        self.navigationItem.title = "Lịch sử cuộc hẹn"
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
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDetailViewCell", for: indexPath) as! AppointmentDetailViewCell
        return cell
    }
}
