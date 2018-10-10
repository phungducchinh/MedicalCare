//
//  DoctorListViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/25/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DoctorListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
        let address = "263-265 Đường Trần Hưng Đạo, Thành Phố Hồ Chí Minh, Việt Nam"
        cell.setUpCell(strAva: "", name: "Trà Văn Hiên", special: "Khoa ngoại B3", hospital: "Bệnh viện Quân Dân Y miền Đông", addHos: address)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statusFrame = UIApplication.shared.statusBarFrame
        let flTrueY = statusFrame.height //+ CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)
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

