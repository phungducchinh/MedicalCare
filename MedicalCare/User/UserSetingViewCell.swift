//
//  UserSetingViewCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/26/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class UserSetingViewCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTitle: UIImageView!
    var idCell = 0
    weak var delegate : HomeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBg.layer.cornerRadius = 4
        self.viewBg.layer.borderWidth = 1.5
        self.viewBg.layer.borderColor = clGreenGardient.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpView(imgTitle : UIImage, title : String, imgButton : UIImage, id : Int){
        self.idCell = id
        self.imgTitle.image = imgTitle
        self.lblTitle.text = title
        self.btnNext.setImage(imgButton, for: .normal)
    }
    @IBAction func actionNext(_ sender: Any) {
        self.delegate?.getIdOfCell(id: idCell)
    }
}
