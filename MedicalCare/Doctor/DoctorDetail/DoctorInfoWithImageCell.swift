//
//  DoctorInfoWithImageCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/25/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class DoctorInfoWithImageCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgTop: UIImageView!
    @IBOutlet weak var imgBottom: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupData(title: String, address: String, time: String){
        lblTitle.text = title
        lblAddress.text = address
        lblTime.text = time
    }
    
    func setupNotImage(arrInfo: [String]){
        imgTop.isHidden = true
        imgBottom.isHidden = true
        lblTime.isHidden = true
        lblAddress.text = cvtArrToString(info: arrInfo)
    }
    
    func cvtArrToString(info: [String]) -> String{
        var str = ""
        if info.count > 0{
            for i in info{
                str += "- "
                str += i
                str += "\n"
            }
            str.removeLast()
            return str
        }else{
            return str
        }
    }
}
