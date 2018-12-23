//
//  MessageViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/29/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import JGProgressHUD

class MessageViewController: MDBaseViewController {
    
    @IBOutlet weak var tvMessage: UITextView!
    @IBOutlet weak var lblTotal: UILabel!
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvMessage.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Góp ý"
        MDProvider.instance.setUpNavigation(controller: self)
    }
    
    @IBAction func actionSendMess(_ sender: Any) {
        guard let message = tvMessage.text , !message.isEmpty else {
            MDProvider.loadAlert(title: "", message: errorMissInfoSendMessage)
            return
        }
        
        guard checkNillstring(str: message) else{
            MDProvider.loadAlert(title: "", message: errorMissInfoSendMessage)
            return
        }
        
        let alertController = UIAlertController(title: "", message: "Xác nhận đã hoàn thành điền nội dung cần góp ý?", preferredStyle: .alert)
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!.topMostViewController()
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!;
        }
        let okAction = UIAlertAction(title: "Đồng ý", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            self.hud.show(in: self.view)
            if let userData = defaultLogin.data(forKey: kUserDefaultkeyLogin), let user = try? JSONDecoder().decode(UserObject.self, from: userData) {
                MDAPIManager.instance.sendMessage(user_id: user.id ?? 0, message: message, success: {success in
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        self.tvMessage.text.removeAll()
                    }
                    MDProvider.loadAlert(title: "", message: success)
                    self.lblTotal.text = "500/500"
                }, failure: {fail, err in
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        self.tvMessage.text.removeAll()
                    }
                    MDProvider.loadAlert(title: "", message: err)
                    self.lblTotal.text = "500/500"
                })
            }else{
                DispatchQueue.main.async {
                    self.hud.dismiss()
                    self.tvMessage.text.removeAll()
                }
            }
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Huỷ bỏ", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            
        }
        alertController.addAction(cancelAction)
        
        topController.present(alertController, animated: true, completion: nil)
    }
    
    func checkNillstring(str : String) -> Bool{
        var arrEnter = [Character]()
        let arrTemp = [Character](repeating: "\n", count: str.count)
        for i in str{
            arrEnter.append(i)
        }
        
        if arrTemp == arrEnter {
            return false
        }else{
            return true
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MessageViewController : UITextViewDelegate{
    func textView(_ textView: UITextView,  shouldChangeTextIn range:NSRange, replacementText text:String ) -> Bool {
        self.lblTotal.text = "\(MESSAGE_LIMIT - tvMessage.text.count)/500"
        return tvMessage.text.count + (text.count - range.length) <= 100// MESSAGE_LIMIT
    }
    
    
}

