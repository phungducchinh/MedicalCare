//
//  MDBaseViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/24/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import SVProgressHUD

class MDBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MDProvider.instance.setNavBgColor(view: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
