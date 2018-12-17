//
//  HistoryViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD
class HistoryViewController: MDBaseViewController {
    
    @IBOutlet weak var tvListAppointment: UITableView!
    let hud = JGProgressHUD(style: .dark)
    var arrAppointment : [AppointmentShow] = []
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
        DispatchQueue.main.async {
            self.getAllAppointment()
        }
    }
    
    func getAllAppointment(){
        hud.show(in: self.view)
        if let userData = defaultLogin.data(forKey: kUserDefaultkeyLogin), let user = try? JSONDecoder().decode(UserObject.self, from: userData) {
            MDAPIManager.instance.getAllAppointmentWithUserID(id: user.id ?? 0,  success: {success in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                    self.arrAppointment = success
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
        let appoint = self.getAppointmentInArr(id: idAppointment)
        if checkDate(dateBook: appoint.dateBook ?? ""){
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
        }else{
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: errorCancelAppointment )
        }
    }
    
    func getAppointmentInArr(id: Int) -> AppointmentShow{
        var result = AppointmentShow(id: 0, user_id: 0, doctor_id: 0, hospital_id: 0, dateBook: "", timeBook: "", problem: "", fee: 0, status: 0, doctor: DoctorAppoinment(id: 0, doctor_name: "", specialize: "", avatar: "", hospital: ""))
        for i in arrAppointment{
            if i.id == id{
                result = i
            }
        }
        return result
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
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAppointment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDetailViewCell", for: indexPath) as! AppointmentDetailViewCell
        if arrAppointment.count > indexPath.row {
            let appointment = arrAppointment[indexPath.row]
            cell.delegate = self
            cell.settingShow(appoint: appointment)
        }
        return cell
    }
}

extension HistoryViewController: AppointmentDetailDelegate{
    func cancelAppointment(idAppointment: Int) {
        DispatchQueue.main.async {
            self.cancelAppointmentWithID(idAppointment: idAppointment)
        }
    }
}

