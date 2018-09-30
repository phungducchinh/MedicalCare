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
    
   
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    
    public func openMapForPlace(lat:Double = 0, long:Double = 0, placeName:String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
    
    func openMap(address : String){
        
//        let urlAddress = URL(string: "http://maps.apple.com/?Bệnh viện Răng Hàm Mặt Tp. HCM, Đường Trần Hưng Đạo, Quận 1, Hồ Chí Minh" )1600,PennsylvaniaAve.,20500
        guard let map = URL(string: "http://maps.apple.com/?address=" + address) else {return}
        UIApplication.shared.open(map)

//        coordinates(forAddress: address) {
//            (location) in
//            guard let location = location else {
//                MDProvider.loadAlert(title: "", message: errWrongAddress)
//                return
//            }
//            self.openMapForPlace(lat: location.latitude, long: location.longitude)
//        }
//                let geocoder = CLGeocoder()
//
//                geocoder.geocodeAddressString(address) { (placemarks, error) in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    } else {
//                        if let location = placemarks?.first?.location {
//                            let query = "?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
//                            let urlString = "http://maps.apple.com/".appending(query)
//                            if let url = URL(string: urlString) {
//                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                            }
//                        }
//                    }
//                }
    }
    
    func call(phoneNumber : String){
        guard let number = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(number)
    }
}



