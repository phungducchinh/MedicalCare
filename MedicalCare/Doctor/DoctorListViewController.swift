//
//  DoctorListViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/25/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD

class DoctorListViewController: MDBaseViewController {

    // MARK: - Private View Controller
    private lazy var doctorPresentView: DoctorPresentViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "DoctorPresentViewController") as! DoctorPresentViewController
        viewController.delegate = self
        viewController.parentView = self
        // Add View Controller as Child View Controller
        if let frame = UIApplication.shared.windows.last?.frame {
            viewController.view.frame = frame
            UIApplication.shared.windows.last?.addSubview(viewController.view)
        }
        
        return viewController
    }()
    
    @IBOutlet weak var tbvListDoctor: UITableView!
    var objFindDoctor : FindDoctor?
    let hud = JGProgressHUD(style: .dark)
    var arrDoctor : [Doctor] = []
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tbvListDoctor.estimatedRowHeight = 80
        tbvListDoctor.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.title = "Danh sách bác sĩ"
        MDProvider.instance.setUpNavigation(controller: self)
        DispatchQueue.main.async {
            self.getData()
        }
    }
    
    func getData(){
        hud.show(in: self.view)
        if self.objFindDoctor != nil{
            MDAPIManager.instance.getAllInfoDoctor(objFindoctor: self.objFindDoctor!, success: {success in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                }
                self.arrDoctor = success
                self.tbvListDoctor.reloadData()
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
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueDoctorToDoctorInfo{
            let vc = segue.destination as? DoctorDetailViewController
            vc?.objDoctor = arrDoctor[row]
        }
        
        if segue.identifier == kSegueDoctorToDoctorHospital{
            let vc = segue.destination as? DoctorHospitalViewController
            vc?.objDoctor = arrDoctor[row]
        }
    }
}

extension DoctorListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDoctor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
//        let address = "263-265 Đường Trần Hưng Đạo, Thành Phố Hồ Chí Minh, Việt Nam"
        if arrDoctor.count > indexPath.row{
            let info = arrDoctor[indexPath.row]
            cell.setUpCell(strAva: info.avatar ?? "", name: info.name ?? "", special: info.specialize ?? "", hospital: info.address ?? "", addHos: info.address ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statusFrame = UIApplication.shared.statusBarFrame
        let flTrueY = statusFrame.height //+ CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)
        self.row = indexPath.row
        self.doctorPresentView.upateData(objDoc: arrDoctor[indexPath.row])
        self.doctorPresentView.view.frame = CGRect(x: -self.view.frame.size.width, y: CGFloat(flTrueY), width: self.doctorPresentView.view.frame.size.width, height: self.tbvListDoctor.frame.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
        UIView.animate(withDuration: 0.3, animations: {
            self.doctorPresentView.view.frame = CGRect(x: 0, y: CGFloat(flTrueY), width: self.doctorPresentView.view.frame.size.width, height: self.tbvListDoctor.frame.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
        }) { (finish) in
            
        }
    }
}

extension DoctorListViewController : DoctorPresentDelegate{
    func closeView() {
        UIView.animate(withDuration: 0.3, animations: {
            let statusFrame = UIApplication.shared.statusBarFrame
            let flTrueY =  statusFrame.height //+ CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)
            self.doctorPresentView.view.frame = CGRect(x: -self.view.frame.size.width, y: CGFloat(flTrueY), width: self.view.frame.size.width, height: self.tbvListDoctor.frame.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
        }) { (finish) in
        }
    }
}

