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
    @objc optional func bookAppointment()
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
    var objDoctor : Doctor?
    
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
    }
    
    func upateData(objDoc: Doctor){
        self.objDoctor = objDoc
        MDProvider.instance.setupImage(strAva: objDoctor?.avatar ?? "", imgView: self.imgAvatar)
        self.lblName.text = objDoctor?.name ?? ""
        self.lblSpeciallize.text = objDoctor?.specialize ?? ""
        if let certificate = objDoctor?.certificate {
            self.lblCertificate.text =  cvtArrToString(info: certificate)
        }else{
            self.lblCertificate.text = ""
        }
        MDProvider.instance.getCoordinate(addressString: objDoctor?.address ?? "", lblPlace: self.lblPlace, completionHandler: {distance , err in
        })
    }
    
    func cvtArrToString(info: [Info]) -> String{
        var str = ""
        if info.count > 0{
            for i in info{
                str += i.name ?? ""
                str += ","
            }
            str.removeLast()
            return str
        }else{
            return str
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueDoctorToDoctorHospital{
            if let vc = segue.destination as? DoctorHospitalViewController{
                
            }
        }
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.closeView!()
    }
    @IBAction func actionCloseView(_ sender: Any) {
        self.delegate?.closeView!()
    }
    @IBAction func actionOpenMap(_ sender: Any) {
        MDProvider.instance.openMap(address: self.objDoctor?.address ?? "")
    }
    
    @IBAction func actionMakeCall(_ sender: Any) {
        MDProvider.instance.call(phoneNumber: self.objDoctor?.phone_number ?? "")
    }
    
    @IBAction func actionOpenDoctorInfo(_ sender: Any) {
        self.delegate?.closeView!()
        self.parentView.performSegue(withIdentifier: kSegueDoctorToDoctorInfo, sender: self)
    }
    
    @IBAction func actionOpenHospitalOfDoctor(_ sender: Any) {
        self.delegate?.closeView!()
        self.parentView.performSegue(withIdentifier: kSegueDoctorToDoctorHospital, sender: self)
    }
    
    @IBAction func actionMakeAppointment(_ sender: Any) {
        print("book appointment")
        self.delegate?.closeView!()
        self.delegate?.bookAppointment!()
    }
    
}
