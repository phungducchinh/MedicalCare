//
//  HealthTableViewCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 11/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class HealthTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var strView: UIView!
    @IBOutlet weak var circleProcess: CircularProgressBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupData(title: String, info: String, progress: Double, id: Int, safe: Int){
        self.lbTitle.text = title
        self.lbInfo.text = info
        if id == 2{
            self.strView.isHidden = true
        }else{
            self.strView.isHidden = false
        }
        circleProcess.labelSize = 17
        circleProcess.safePercent = safe
        circleProcess.lineWidth = 3
        circleProcess.setProgress(to: progress, withAnimation: true)
    }
}
