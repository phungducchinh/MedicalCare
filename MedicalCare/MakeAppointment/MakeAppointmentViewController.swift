//
//  MakeAppointmentViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/28/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD

class MakeAppointmentViewController: MDBaseViewController {

    // MARK: - Private View Controller
    private lazy var chooseTimeView: ChooseTimeViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ChooseTimeViewController") as! ChooseTimeViewController
        viewController.delegate = self
        viewController.type_time = 0
        // Add View Controller as Child View Controller
        if let frame = UIApplication.shared.windows.last?.frame {
            viewController.view.frame = frame
            UIApplication.shared.windows.last?.addSubview(viewController.view)
        }
        
        return viewController
    }()
    
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnDoctor: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var tvProblem: UITextView!
    
     let arr = ["Chọn bác sĩ","Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B" , "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B"]
    
    let hud = JGProgressHUD(style: .dark)
    var arrHospital : [Hospital] = []
    var arrDoctor :  [DoctorShow] = []
    var arrShowHospital : [String] = ["Chọn bệnh viện"]
    var arrShowDoctor: [String] = ["Chọn bác sĩ"]
    var arrShowTime: [String] = ["Chọn thời gian"]
    var time = ""
    var date = ""
    var idAppointment = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tvProblem.delegate = self
        DispatchQueue.main.async {
            self.getAllHospital()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBook(_ sender: Any) {
        print(btnHospital.titleLabel?.text ?? "", " ",btnDoctor.titleLabel?.text ?? "", " ", date, " ",time )
        if let userData = defaultLogin.data(forKey: kUserDefaultkeyLogin), let user = try? JSONDecoder().decode(UserObject.self, from: userData) {
            let idHospital = getHospital(name: btnHospital.titleLabel?.text ?? "").id ?? 0
            let idDoctor = getDoctor(name: btnDoctor.titleLabel?.text ?? "").id ?? 0
            let idUser = user.id ?? 0
            guard idHospital > 0 && idDoctor > 0 && date != "" && time != "" && idUser > 0  else {
                MDProvider.loadAlert(title: "", message: errorMissInfoBookAppointment)
                return
            }
            let appointment = Appointment(id: 0, user_id: idUser, doctor_id: idDoctor, hospital_id: idHospital, dateBook: date, timeBook: time, problem: self.tvProblem.text ?? "", fee: getDoctor(name: btnDoctor.titleLabel?.text ?? "").fee ?? 0, status: 0)
            DispatchQueue.main.async {
                self.bookAppointment(appointment: appointment)
            }
        }
    }

    @IBAction func acChooseHospital(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arrShowHospital, controller: self, idButton: 0)
    }
    
    @IBAction func acChooseDoctor(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arrShowDoctor, controller: self, idButton: 1)
    }
    @IBAction func acChooseTime(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arrShowTime, controller: self, idButton: 2)
    }
   
    func getAllHospital(){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllHospital(url: kAPIGetAllHospital, success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.arrHospital = success
            if self.arrHospital.count > 0{
                self.arrShowHospital  = ["Chọn bệnh viện"]
                self.arrShowDoctor = ["Chọn bác sĩ"]
                self.arrShowTime = ["Chọn thời gian"]
                DispatchQueue.main.async {
                    self.btnDoctor.setTitle(self.arrShowDoctor[0], for: .normal)
                    self.btnTime.setTitle(self.arrShowTime[0], for: .normal)
                    self.btnDoctor.setTitleColor(clDarkTex, for: .normal)
                    self.btnTime.setTitleColor(clDarkTex, for: .normal)
                }
                for i in self.arrHospital{
                    self.arrShowHospital.append(i.name ?? "")
                }
            }
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    
    func getHospital(name: String) -> Hospital{
        var id = Hospital(id: 0, name: "", phone_number: "", info: "", avatar: "", address: "")
        if arrHospital.count > 0{
            for i in arrHospital{
                if i.name == name{
                    id = i
                }
            }
        }
        return id
    }
    
    func getDoctor(name: String) -> DoctorShow{
        var id = DoctorShow(id: 0, name: "", type_time: 0, fee: 0, list_time: [""])
        if arrDoctor.count > 0{
            for i in arrDoctor{
                if i.name == name{
                    id = i
                }
            }
        }
        return id
    }
    
    func getAllDoctor(id: Int){
        hud.show(in: self.view)
        MDAPIManager.instance.getAllInfoDoctorShow(id: id, success: {success in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            self.arrDoctor = success
            if self.arrDoctor.count > 0{
                self.arrShowDoctor = ["Chọn bác sĩ"]
                self.arrShowTime = ["Chọn thời gian"]
                DispatchQueue.main.async {
                    self.btnDoctor.setTitle(self.arrShowDoctor[0], for: .normal)
                    self.btnTime.setTitle(self.arrShowTime[0], for: .normal)
                    self.btnDoctor.setTitleColor(clDarkTex, for: .normal)
                    self.btnTime.setTitleColor(clDarkTex, for: .normal)
                }
                for i in self.arrDoctor{
                    self.arrShowDoctor.append(i.name ?? "")
                }
            }
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    
    func bookAppointment(appointment: Appointment){
        hud.show(in: self.view)
        MDAPIManager.instance.bookAppointment(appointment: appointment,success: {success in
            print(success)
            self.idAppointment = success
            DispatchQueue.main.async {
                self.hud.dismiss()
                self.btnHospital.setTitle(self.arrShowDoctor[0], for: .normal)
                self.btnDoctor.setTitle(self.arrShowDoctor[0], for: .normal)
                self.btnTime.setTitle(self.arrShowTime[0], for: .normal)
                self.btnHospital.setTitleColor(clDarkTex, for: .normal)
                self.btnDoctor.setTitleColor(clDarkTex, for: .normal)
                self.btnTime.setTitleColor(clDarkTex, for: .normal)
                self.tvProblem.text = "Mô tả triệu chứng"
                
                let alertController = UIAlertController(title: "", message:  "Đặt lịch hẹn thành công!\nMã lịch hẹn của bạn là: \(success)", preferredStyle: .alert)
                var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!.topMostViewController()
                while ((topController.presentedViewController) != nil) {
                    topController = topController.presentedViewController!;
                }
                let okAction = UIAlertAction(title: "Đống ý", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
                    self.performSegue(withIdentifier: kSegueMakeToCfAppointment, sender: nil)
                }
                alertController.addAction(okAction)
                topController.present(alertController, animated: true, completion: nil)
            }
        }, failure: {fail, err in
            DispatchQueue.main.async {
                self.hud.dismiss()
            }
            MDProvider.loadAlert(title: "", message: err)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueMakeToCfAppointment{
            if let vc = segue.destination as? AppointmentConfirmViewController{
                vc.id = self.idAppointment
            }
        }
    }
}

extension MakeAppointmentViewController: UITextViewDelegate{
    func textView(_ textView: UITextView,  shouldChangeTextIn range:NSRange, replacementText text:String ) -> Bool {
        return tvProblem.text.count + (text.count - range.length) <= 200
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tvProblem.text.removeAll()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tvProblem.text == "" {
            tvProblem.text = "Mô tả triệu chứng"
        }
    }
}

extension MakeAppointmentViewController : DropDownDelegate{
    func getValueIndropDown(index: Int, idIndex: Int) {
        switch idIndex {
        case 0:
            btnHospital.setTitle(arrShowHospital[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnHospital, index: index)
            if index != 0{
                DispatchQueue.main.async {
                    self.getAllDoctor(id: self.getHospital(name: self.btnHospital.titleLabel?.text ?? "").id ?? 0)
                }
            }
        case 1:
            btnDoctor.setTitle(arrShowDoctor[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnDoctor, index: index)
            if index != 0{
                self.arrShowTime = ["Chọn thời gian"]
                self.arrShowTime += self.getDoctor(name: arrShowDoctor[index]).list_time ?? []
            }
        case 2:
            btnTime.setTitle(arrShowTime[index], for: .normal)
            if index != 0{
                btnTime.setTitleColor(clTextTitle, for: .normal)
                self.date = arrShowTime[index]
                self.chooseTimeView.view.frame = CGRect(x: -self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
                UIView.animate(withDuration: 0.3, animations: {
                    self.chooseTimeView.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
                }) { (finish) in
                    let type_time = self.getDoctor(name: self.btnDoctor.titleLabel?.text ?? "").type_time ?? 0
                    self.chooseTimeView.setupTimePicker(typeTime: type_time)
                }
            }else{
                btnTime.setTitleColor(clDarkTex, for: .normal)
                self.date = ""
                self.time = ""
            }
        default:
            print("choose " , index , "on button ", idIndex)
        }
    }
}

extension MakeAppointmentViewController : DoctorPresentDelegate{
    func closeView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.chooseTimeView.view.frame = CGRect(x: -self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
        }) { (finish) in
        }
    }
    
    func sendDate(date : String){
        print(date)
        self.time = date
        btnTime.setTitle((btnTime.titleLabel?.text)! + " " + date, for: .normal)
    }
}
