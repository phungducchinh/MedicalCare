//
//  AppointmentConfirmViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/28/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class AppointmentConfirmViewController: MDBaseViewController {

    @IBOutlet weak var tvListAppointment: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        if tvListAppointment.contentSize.height > tvListAppointment.frame.height {
//            tvListAppointment.isScrollEnabled = true
//        }else{
//            tvListAppointment.isScrollEnabled = false
//        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MDProvider.instance.setUpNavigation(controller: self)
        tvListAppointment.estimatedRowHeight = 80
        tvListAppointment.rowHeight = UITableViewAutomaticDimension
        tvListAppointment.separatorStyle = .none
        self.navigationItem.title = "Chi tiết cuộc hẹn"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}

extension AppointmentConfirmViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDetailViewCell", for: indexPath) as! AppointmentDetailViewCell
        return cell
    }
}
