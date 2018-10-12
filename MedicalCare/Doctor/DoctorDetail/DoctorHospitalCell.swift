//
//  DoctorHospitalCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/26/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class DoctorHospitalCell: UITableViewCell {

    @IBOutlet weak var imgHospital: UIImageView!
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var lblHospitalName: UILabel!
    @IBOutlet weak var imgHospitalAddress: UILabel!
    
    var idCell = 0
    var phone = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupEmergencyCell (name : String, address : String, phone : String){
        lblHospitalName.text = name
        imgHospitalAddress.text = address
        self.phone = phone
    }
    
    @IBAction func actionOpenMap(_ sender: Any) {
//        let address = "263-265 Đường Trần Hưng Đạo, Thành Phố Hồ Chí Minh, Việt Nam"
        MDProvider.instance.openMap(address: imgHospitalAddress.text ?? "")
    }
    @IBAction func actionOpenPhone(_ sender: Any) {
        MDProvider.instance.call(phoneNumber: self.phone )
    }
}
