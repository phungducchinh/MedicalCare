//
//  DoctorHospitalCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/26/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import CoreLocation
class DoctorHospitalCell: UITableViewCell , CLLocationManagerDelegate{

    @IBOutlet weak var imgHospital: UIImageView!
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var lblHospitalName: UILabel!
    @IBOutlet weak var imgHospitalAddress: UILabel!
    
    var idCell = 0
    let locationManager : CLLocationManager = CLLocationManager()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locationManager.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionOpenMap(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        MDProvider.instance.openMap(address: "14,Ly%20tu%20trong,%20quan%201.,70000")
    }
    @IBAction func actionOpenPhone(_ sender: Any) {
    }
}
