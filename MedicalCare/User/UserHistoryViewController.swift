//
//  UserHistoryViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD

class UserHistoryViewController: MDBaseViewController {
    
    @IBOutlet weak var tbvListAppointment: UITableView!
    var doctor_id = 0
    let hud = JGProgressHUD(style: .dark)
    var arrAppointmentDoctor : [AppointmentDoctorShow] = []
    
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
//        DispatchQueue.global(qos: .background).async {
//            self.getAllAppointment()
//        }
        DispatchQueue.main.async {
            self.getAllAppointment()
        }
    }
    
    func getAllAppointment(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllAppointmentWithDoctorID(doctor_id: doctor_id,  success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
                self.arrAppointmentDoctor = success
                self.tbvListAppointment.reloadData()
            }
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    
    func cancelAppointmentWithID(idAppointment: Int){
        hud.show(in: self.view)
        let appoint = self.getAppointmentInArr(id: idAppointment)
        MDAPIManager.instance.cancelAppointmentWithID(idAppointment: appoint.id ?? 0, user_id: appoint.user_id ?? 0, doctor_id: appoint.doctor?.id ?? 0,  success: {success in
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
    }
    
    func getAppointmentInArr(id: Int) -> AppointmentDoctorShow{
        var result = AppointmentDoctorShow(id: 0, user_id: 0, doctor_id: 0, hospital_id: 0, dateBook: "", timeBook: "", problem: "", fee: 0, status: 0, user_name: "", doctor: DoctorAppoinmentShow(id: 0, doctor_name: "", specialize: "", hospital: ""))
        for i in arrAppointmentDoctor{
            if i.id == id{
                result = i
            }
        }
        return result
    }
    // check type of user and chose api for show info
    
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
        return arrAppointmentDoctor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserAppointmentDetailViewCell", for: indexPath) as! AppointmentDetailViewCell
        if arrAppointmentDoctor.count > indexPath.row {
            let appointment = arrAppointmentDoctor[indexPath.row]
            cell.delegate = self
            cell.settingDoctorApm(appoint: appointment)
        }
        return cell
    }
}

extension UserHistoryViewController: AppointmentDetailDelegate{
    func cancelAppointment(idAppointment: Int) {
        DispatchQueue.global(qos: .background).async {
            self.cancelAppointmentWithID(idAppointment: idAppointment)
        }
    }
}
