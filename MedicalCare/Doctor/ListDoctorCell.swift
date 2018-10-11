//
//  ListDoctorCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/25/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class ListDoctorCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSpecallize: UILabel!
    @IBOutlet weak var lblHospital: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(strAva: String, name: String, special: String, hospital: String, addHos: String){
        MDProvider.instance.setupImage(strAva: strAva, imgView: imgAvatar)
        lblName.text = name
        lblSpecallize.text = special
        lblHospital.text =  addHos
        MDProvider.instance.getCoordinate(addressString: addHos, lblPlace: lblPlace, completionHandler: {distance , err in
//            self.lblPlace.text = "\(distance)" + " km"
        })
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }

}
