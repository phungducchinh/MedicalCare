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
        guard  imageData != nil else {
            return #imageLiteral(resourceName: "default-avatar")
        }
        return (UIImage(data: imageData!))!
    }
    
    func openMap(address : String){
        let maps = "http://maps.apple.com/?address="
        let url = maps + address
        let urlString = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(urlString as Any)
        UIApplication.shared.open(urlString!)
    }
    
    func getCoordinate( addressString : String, lblPlace : UILabel,
                        completionHandler: @escaping(Double, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    guard let distance : Double = appDelegate.userLocation?.distance(from: location) else {
//                        completionHandler(0, error as NSError?)
//                        return
//                    }
                    guard let userLocation : CLLocation = appDelegate.userLocation else{
                        completionHandler(0, error as NSError?)
                        return
                    }
                    self.caculateDistance(fromLocation: userLocation, toLocation: location, lable: lblPlace)
//                    completionHandler ((distance/1000).roundToDecimal(1), nil)
                    return
                }
            }
            
            completionHandler(0, error as NSError?)
        }
    }
    
    func caculateDistance(fromLocation : CLLocation, toLocation : CLLocation, lable : UILabel) {
        let directionRequest = MKDirectionsRequest()
        let mkPlacemarkOrigen = MKPlacemark(coordinate: fromLocation.coordinate, addressDictionary: nil)
        let mkPlacemarkDestination = MKPlacemark(coordinate: toLocation.coordinate, addressDictionary: nil)
        let source: MKMapItem = MKMapItem(placemark: mkPlacemarkOrigen)
        let destination: MKMapItem = MKMapItem(placemark: mkPlacemarkDestination)
        directionRequest.source = source
        directionRequest.destination = destination
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            if error != nil { print("Error calculating direction - \(String(describing: error?.localizedDescription))") }
            else {
                for route in (response?.routes)!{
                    print("Distance = \(route.distance)")
//                    for step in route.steps{
//                        print(step.instructions)
//                    }
                    lable.text = "\((route.distance/1000).roundToDecimal(1)) km"
                }
            }
        }
    }
    
    func call(phoneNumber : String){
        guard let number = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(number)
    }
    
    func setupImage(strAva : String, imgView : UIImageView){
        if strAva != ""{
            imgView.image = MDProvider.instance.ConvertBase64StringToImage(imageBase64String: strAva)
        }else{
            imgView.image = #imageLiteral(resourceName: "default-avatar")
        }
    }
    
    func caculateYears(birthDay: String) -> Int{
        guard birthDay != "" else {
            return 0
        }
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let userBirthday = dateFormatter.date(from: birthDay)
        let unitFlags = Set<Calendar.Component>([.day, .month, .year])
        
        let components = calendar.dateComponents(unitFlags, from: userBirthday!)
        let userYear = components.year ?? 0
        return (year - userYear)
        
    }
    
    func showDropDown(button : UIButton, datasource : [String], controller : UIViewController, idButton : Int){
        var isScroll = false
        var heightOfTb : CGFloat = 0
        let trueOriginY : CGFloat = button.frame.origin.y + button.frame.height + 1
        let trueHeight = button.frame.height * CGFloat(datasource.count)
        let statusFrame = UIApplication.shared.statusBarFrame
        
        let freeHeightBottom = UIScreen.main.bounds.height - statusFrame.height - button.frame.origin.y -  (controller.navigationController?.navigationBar.frame.height ?? 0) - button.frame.height + 1
        
        if trueHeight > freeHeightBottom{
            isScroll = true
            heightOfTb = freeHeightBottom
        }else{
            heightOfTb = trueHeight
            isScroll = false
        }
        
        DropDownListView.instance.setupDropDown(view: controller.view, isScroll: isScroll, x: button.frame.origin.x , y: trueOriginY , width: button.frame.width, height: heightOfTb , datasource: datasource, controller : controller,  idCell : idButton)
    }
    
    func changeClTextBtn(btn: UIButton, index: Int){
        if index != 0{
            btn.setTitleColor(clTextTitle, for: .normal)
        }else{
            btn.setTitleColor(clDarkTex, for: .normal)
        }
    }
}



