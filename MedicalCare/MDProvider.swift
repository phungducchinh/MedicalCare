//
//  MDProvider.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MDProvider  {
    
    
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
    
    class func loadAlert(title: String, message: String) {
        
        var topController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!;
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        topController.present(alertController, animated:true, completion:nil)
    }
    
    func ConvertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func openMap(address : String){
        let maps = "http://maps.apple.com/?address="
        let url = maps + address
        let urlString = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(urlString as Any)
        UIApplication.shared.open(urlString!)
    }
    
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(Double, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    guard let distance : Double = appDelegate.userLocation?.distance(from: location) else {
                        completionHandler(0, error as NSError?)
                        return
                    }
                    completionHandler ((distance/1000).roundToDecimal(1), nil)
                    return
                }
            }
            
            completionHandler(0, error as NSError?)
        }
    }
    
    func call(phoneNumber : String){
        guard let number = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(number)
    }
}



