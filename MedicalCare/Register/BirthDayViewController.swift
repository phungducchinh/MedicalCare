//
//  BirthDayViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class BirthDayViewController: UIViewController {

    @IBOutlet weak var pkBirthday: UIDatePicker!
    
    var userInfo : UserObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isHidden = true
        MDProvider.instance.setShadown(view: pkBirthday, borderShadow: 2.0, bgColor :.white , shadownColor : .black)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionNext(_ sender: Any) {
        self.performSegue(withIdentifier: kSegueBirthdayToWeight, sender: self)
    }
    
    @IBAction func changeBirthday(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.userInfo?.birthday = dateFormatter.string(from: (sender as AnyObject).date)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueBirthdayToWeight {
            if let vc = segue.destination as? ProfileRegiterViewController{
                vc.userInfo = self.userInfo
            }
        }
    }

}
