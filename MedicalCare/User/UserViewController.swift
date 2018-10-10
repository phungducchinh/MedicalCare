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
    
    var gradientLayer: CAGradientLayer!
    var arrImgTitle : [UIImage] = [#imageLiteral(resourceName: "ico_change_userinfo") , #imageLiteral(resourceName: "ico_history")]
    var arrImgButton : [UIImage] = [#imageLiteral(resourceName: "btn_left_arrow"), #imageLiteral(resourceName: "btn_left_arrow")]
    var arrTitle : [String] = ["Cập nhật thông tin" , "Xem lịch hẹn" ]
    let firstCl = UIColor(red: 25/255, green: 115/255, blue: 159/255, alpha: 1).cgColor
    let secondCl = UIColor(red: 53/255, green: 216/255, blue: 166/255, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        MDProvider.instance.setUpNavigation(controller: self)

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
        
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(#imageLiteral(resourceName: "ico_logout"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(logout), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButton(item1, animated: true)
        
        self.navigationController?.navigationBar.setGradientBackground(colors: [.clear])
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        lblUserOld.text = "\(MDProvider.instance.caculateYears(birthDay: "19/12/1996")) years"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userData = defaultLogin.data(forKey: kUserDefaultkeyLogin), let user = try? JSONDecoder().decode(UserObject.self, from: userData) {
            lblUserName.text = user.name ?? ""
            let birthD = user.birthday ?? ""
            lblUserOld.text = "\(MDProvider.instance.caculateYears(birthDay: birthD)) years"
            lblUserAddress.text = user.address ?? ""
            lblUserHeight.text = "\(user.height ?? 0)"
            lblUserWeight.text = "\(user.weight ?? 0)"
            lblUserGender.text = user.gender
            
            let defaultImg : UIImage = #imageLiteral(resourceName: "default-avatar")
            
            guard let imgStr = user.avatar else{
                img.image = ConvertBase64StringToImage(imageBase64String: defaultImg.renderResizedImage(newWidth: 400).toBase64() )
                return
            }
            img.image = ConvertBase64StringToImage(imageBase64String:  imgStr )
        }
    }
    
    
    @objc func logout(){
        print("log out")
        defaultLogin.removeObject(forKey: kUserDefaultkeyLogin)
        self.performSegue(withIdentifier: kSegueUserToLogin, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func ConvertBase64StringToImage (imageBase64String:String) -> UIImage {
        guard let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0)) else{
            return #imageLiteral(resourceName: "default-avatar")
        }
        let image = UIImage(data: imageData)
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
        cell.delegate = self
        return cell
    }
}

extension UserViewController : HomeCellDelegate{
    func getIdOfCell(id: Int) {
        switch id {
        case 0:
            print("update user info")
            self.performSegue(withIdentifier: kSegueUserToUpdateInfo, sender: self)
        case 1:
            self.performSegue(withIdentifier: kSegueUserToListAppointment, sender: self)
        default:
            print(id)
        }
    }
}
