//
//  MDProvider.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

class MDProvider {
    
    public static let instance = MDProvider()
    var control = UIViewController()
    func setShadown(view : UIView, borderShadow : CGFloat, bgColor : UIColor, shadownColor : UIColor){
        let shadowSize : CGFloat = borderShadow
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: view.frame.size.width + shadowSize,
                                                   height: view.frame.size.height + shadowSize))
        view.layer.masksToBounds = false
        view.layer.shadowColor = shadownColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowPath = shadowPath.cgPath
        view.backgroundColor = bgColor
    }
    
    func setNavBgColor(view : UIViewController){
        var colors = [UIColor]()
        colors.append(UIColor(red: 25/255, green: 115/255, blue: 159/255, alpha: 1))
        colors.append(UIColor(red: 53/255, green: 216/255, blue: 166/255, alpha: 1))
        view.navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    
    func setUpNavigation(controller : UIViewController){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(#imageLiteral(resourceName: "btn_back_white"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.control = controller
        btn1.addTarget(self, action: #selector(back), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        controller.navigationItem.setLeftBarButton(item1, animated: true)
    }
    
    @objc func back(){
        self.control.navigationController?.popViewController(animated: true)
    }
}
