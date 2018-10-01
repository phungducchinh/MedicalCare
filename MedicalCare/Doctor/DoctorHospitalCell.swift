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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionOpenMap(_ sender: Any) {
        let address = "263-265 Đường Trần Hưng Đạo, Thành Phố Hồ Chí Minh, Việt Nam"
        MDProvider.instance.openMap(address: address)
        
//        MDProvider.instance.getCoordinate(addressString: address, completionHandler: {distance , err in
//            print(distance)
//        })
    }
    @IBAction func actionOpenPhone(_ sender: Any) {
    }
}
