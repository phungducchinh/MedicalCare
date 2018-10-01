//
//  DoctorDetailViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/25/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class DoctorDetailViewController: MDBaseViewController {
    @IBOutlet weak var tbvDoctorInfo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tbvDoctorInfo.contentSize.height > tbvDoctorInfo.frame.height{
            tbvDoctorInfo.isScrollEnabled = true
        }else{
            tbvDoctorInfo.isScrollEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Thông tin bác sĩ"
        MDProvider.instance.setUpNavigation(controller: self)
        tbvDoctorInfo.estimatedRowHeight = 80
        tbvDoctorInfo.rowHeight = UITableViewAutomaticDimension
        tbvDoctorInfo.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DoctorDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorCell", for: indexPath) as! ListDoctorCell
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell", for: indexPath) as! DoctorInfoCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoWithImageCell", for: indexPath) as! DoctorInfoWithImageCell
            return cell
        }
    }
    
    
}
