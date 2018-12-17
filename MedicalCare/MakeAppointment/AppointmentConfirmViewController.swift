//
//  AppointmentConfirmViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/28/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD

class AppointmentConfirmViewController: MDBaseViewController {

    @IBOutlet weak var tvListAppointment: UITableView!
    let hud = JGProgressHUD(style: .dark)
    var id = 0
    var appointment : AppointmentShow?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MDProvider.instance.setUpNavigation(controller: self)
        tvListAppointment.estimatedRowHeight = 80
        tvListAppointment.rowHeight = UITableViewAutomaticDimension
        tvListAppointment.separatorStyle = .none
        self.navigationItem.title = "Chi tiết cuộc hẹn"
        DispatchQueue.main.async {
            self.getAllAppointment()
        }
    }
    func getAllAppointment(){
        hud.show(in: self.view)
        if let userData = defaultLogin.data(forKey: kUserDefaultkeyLogin), let user = try? JSONDecoder().decode(UserObject.self, from: userData) {
            MDAPIManager.instance.getAppointmentWithID(id: self.id,  success: {success in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                    self.appointment = success
                    self.tvListAppointment.reloadData()
                }
            }, failure: {fail, err in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                }
                MDProvider.loadAlert(title: "", message: err)
            })
        }else{
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
        }
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
    
    func cancelAppointmentWithID(idAppointment: Int){
        hud.show(in: self.view)
        if checkDate(dateBook: self.appointment?.dateBook ?? ""){
            MDAPIManager.instance.cancelAppointmentWithID(idAppointment: self.appointment?.id ?? 0, user_id: self.appointment?.user_id ?? 0, doctor_id: self.appointment?.doctor?.id ?? 0,  success: {success in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                    self.getAllAppointment()
                }
            }, failure: {fail, err in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                }
                MDProvider.loadAlert(title: "", message: err)
            })
        }else{
            DispatchQueue.main.async {
            self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: errorCancelAppointment )
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    func checkDate(dateBook: String) -> Bool{
        let date = Date()
//        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let bookday = dateFormatter.date(from: dateBook)
        if date < bookday!{
            return true
        }else{
            return false
        }
    }
}

extension AppointmentConfirmViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDetailViewCell", for: indexPath) as! AppointmentDetailViewCell
        if let appoint = appointment{
            cell.settingShow(appoint: appoint)
        }
        return cell
    }
}
