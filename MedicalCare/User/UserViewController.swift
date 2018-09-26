//
//  UserViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/26/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class UserViewController: MDBaseViewController {
    
    @IBOutlet weak var tbvButton: UITableView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserOld: UILabel!
    @IBOutlet weak var lblUserAddress: UILabel!
    @IBOutlet weak var lblUserHeight: UILabel!
    @IBOutlet weak var lblUserWeight: UILabel!
    @IBOutlet weak var lblUserGender: UILabel!
    var imgeStr = ""
    var gradientLayer: CAGradientLayer!
    var arrImgTitle : [UIImage] = [#imageLiteral(resourceName: "img_btn_phone_call") , #imageLiteral(resourceName: "img_btn_navigation"), #imageLiteral(resourceName: "ico_btn_user")]
    var arrImgButton : [UIImage] = [#imageLiteral(resourceName: "btn_left_arrow"), #imageLiteral(resourceName: "btn_left_arrow"), #imageLiteral(resourceName: "btn_left_arrow")]
    var arrTitle : [String] = ["Cập nhật thông tin" , "Xem lịch hẹn" , "Cài đặt"]
    let firstCl = UIColor(red: 25/255, green: 115/255, blue: 159/255, alpha: 1).cgColor
    let secondCl = UIColor(red: 53/255, green: 216/255, blue: 166/255, alpha: 1).cgColor
    override func viewDidLoad() {
        super.viewDidLoad()
//        MDProvider.instance.setUpNavigation(controller: self)
        let defaultImg : UIImage = #imageLiteral(resourceName: "default-avatar")
        
        if imgeStr == ""{
            imgeStr = defaultImg.renderResizedImage(newWidth: 400).toBase64()
        }
        
        img.image = ConvertBase64StringToImage(imageBase64String:  imgeStr )
        print(imgeStr)
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        img.layer.borderWidth = 1.5
        img.layer.borderColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1).cgColor
        self.view.layerGradient(colors: [firstCl, secondCl])
        tbvButton.separatorStyle = .none
        tbvButton.estimatedRowHeight = 80
        tbvButton.rowHeight = UITableViewAutomaticDimension
        
        if tbvButton.contentSize.height > tbvButton.frame.height {
            tbvButton.isScrollEnabled = true
        }else{
            tbvButton.isScrollEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func ConvertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func createGradientLayer() {
        
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [firstCl, secondCl]
        
        self.view.layer.addSublayer(gradientLayer)
    }

}

extension UserViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImgTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSetingViewCell", for: indexPath) as! UserSetingViewCell
        cell.setUpView(imgTitle: arrImgTitle[indexPath.row], title: arrTitle[indexPath.row], imgButton: arrImgButton[indexPath.row] , id : indexPath.row)
        return cell
    }
    
    
}