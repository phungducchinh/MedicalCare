//
//  HomeCollectionViewCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/24/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

protocol HomeCellDelegate : class {
    func getIdOfCell(id : Int)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnHome: UIButton!
    
    var nbOfCell = 0
    weak var delegate : HomeCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(idCell : Int, imgeBtn : UIImage){
        self.nbOfCell = idCell
        btnHome.setImage(imgeBtn, for: .normal)
    }
    
    @IBAction func actionBtnHome(_ sender: Any) {
        self.delegate?.getIdOfCell(id: nbOfCell)
    }
    
}
