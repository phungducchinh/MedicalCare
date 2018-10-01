//
//  HospitalPharmacyDetialViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/1/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class HospitalPharmacyDetialViewController: MDBaseViewController {

    @IBOutlet weak var imgAva: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var tvInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MDProvider.instance.setUpNavigation(controller: self)
        
        if tvInfo.contentSize.height > tvInfo.frame.height{
            tvInfo.isScrollEnabled = true
        }else{
            tvInfo.isScrollEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionOpenMap(_ sender: Any) {
        
    }
    
    @IBAction func actionCall(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
