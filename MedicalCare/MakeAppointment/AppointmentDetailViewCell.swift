//
//  AppointmentDetailViewCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/28/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class AppointmentDetailViewCell: UITableViewCell {

    @IBOutlet weak var imgAvaDoctor: UIImageView!
    @IBOutlet weak var lblDoctorName: UILabel!
    @IBOutlet weak var lblSpecilize: UILabel!
    @IBOutlet weak var lblHospital: UILabel!
    @IBOutlet weak var lblDateTim: UILabel!
    @IBOutlet weak var tvNote: UITextView!
    @IBOutlet weak var lblFee: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionCancelAppointment(_ sender: Any) {
        
    }
}
