//
//  DoctorPresentViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/25/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

@objc protocol DoctorPresentDelegate : class {
    @objc optional func closeView()
    @objc optional func sendDate(date : String)
}

class DoctorPresentViewController: UIViewController {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSpeciallize: UILabel!
    @IBOutlet weak var lblCertificate: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    
    weak var delegate : DoctorPresentDelegate?
    var parentView = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewBg.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.5)
        self.view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewBg.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        imgAvatar.image = MDProvider.instance.ConvertBase64StringToImage(imageBase64String: strAva)
//        lblName.text = name
//        lblSpecallize.text = special
//        lblHospital.text = hospital + " , " + addHos
//        MDProvider.instance.getCoordinate(addressString: addHos, completionHandler: {distance , err in
//            self.lblPlace.text = "\(distance)" + " km"
//        })
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.closeView!()
    }
    @IBAction func actionCloseView(_ sender: Any) {
        self.delegate?.closeView!()
    }
    @IBAction func actionOpenMap(_ sender: Any) {
        
    }
    
    @IBAction func actionMakeCall(_ sender: Any) {
        
    }
    
    @IBAction func actionOpenDoctorInfo(_ sender: Any) {
        self.delegate?.closeView!()
        self.parentView.performSegue(withIdentifier: kSegueDoctorToDoctorInfo, sender: nil)
    }
    
    @IBAction func actionOpenHospitalOfDoctor(_ sender: Any) {
        self.delegate?.closeView!()
        self.parentView.performSegue(withIdentifier: kSegueDoctorToDoctorHospital, sender: nil)
    }
    
    @IBAction func actionMakeAppointment(_ sender: Any) {
        print("book appointment")
    }
    
}
