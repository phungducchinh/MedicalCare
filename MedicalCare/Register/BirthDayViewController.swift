//
//  BirthDayViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class BirthDayViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var pkBirthday: UIDatePicker!
    @IBOutlet weak var imgAvatar: UIImageView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var userInfo : UserObject?
    var imagePicker: UIImagePickerController!
    var isChangeInfo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isHidden = true
        MDProvider.instance.setShadown(view: pkBirthday, borderShadow: 2.0, bgColor :.white , shadownColor : .black)
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if isChangeInfo{
            let date = userInfo?.birthday ?? "23-10-2018"
            let userBirthday = dateFormatter.date(from: date)
            pkBirthday.setDate(userBirthday!, animated: false)
            MDProvider.instance.setupImage(strAva: userInfo?.avatar ?? "", imgView: self.imgAvatar)
        }else{
            pkBirthday.setDate(dateFormatter.date(from: "23-10-2018")!, animated: false)
            imgAvatar.image = #imageLiteral(resourceName: "default-avatar")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionNext(_ sender: Any) {
        self.performSegue(withIdentifier: kSegueBirthdayToWeight, sender: self)
    }
    
    @IBAction func changeBirthday(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.userInfo?.birthday = dateFormatter.string(from: (sender as AnyObject).date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueBirthdayToWeight {
            if let img1 : UIImage = imgAvatar.image{//?.cropImage(navigationSize: 44){
                self.userInfo?.avatar = img1.renderResizedImage(newWidth: 400).toBase64()
            }
            if let vc = segue.destination as? ProfileRegiterViewController{
                vc.userInfo = self.userInfo
                vc.isChangeInfo = self.isChangeInfo
            }
        }
    }
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOpenCamera(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Add image to Library
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Hình của bạn sẽ được lưu vào thư viện ảnh.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imgAvatar.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
}
