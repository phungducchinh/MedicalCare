//
//  MakeAppointmentViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/28/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class MakeAppointmentViewController: MDBaseViewController {

    // MARK: - Private View Controller
    private lazy var chooseTimeView: ChooseTimeViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ChooseTimeViewController") as! ChooseTimeViewController
        viewController.delegate = self
        viewController.type_time = 0
        // Add View Controller as Child View Controller
        if let frame = UIApplication.shared.windows.last?.frame {
            viewController.view.frame = frame
            UIApplication.shared.windows.last?.addSubview(viewController.view)
        }
        
        return viewController
    }()
    
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnDoctor: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var tvProblem: UITextView!
    
     let arr = ["Chọn bác sĩ","Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B" , "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B", "Bác sĩ Nguyễn Văn A" , "Bác sĩ Nguyễn Thị B"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvProblem.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBook(_ sender: Any) {
         self.performSegue(withIdentifier: kSegueMakeToCfAppointment, sender: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    @IBAction func acChooseHospital(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arr, controller: self, idButton: 0)
    }
    
    @IBAction func acChooseDoctor(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arr, controller: self, idButton: 1)
    }
    @IBAction func acChooseTime(_ sender: Any) {
        MDProvider.instance.showDropDown(button: sender as! UIButton, datasource: arr, controller: self, idButton: 2)
    }
}

extension MakeAppointmentViewController: UITextViewDelegate{
    func textView(_ textView: UITextView,  shouldChangeTextIn range:NSRange, replacementText text:String ) -> Bool {
        return tvProblem.text.count + (text.count - range.length) <= 200
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tvProblem.text.removeAll()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tvProblem.text == "" {
            tvProblem.text = "Mô tả triệuchứngg"
        }
    }
}

extension MakeAppointmentViewController : DropDownDelegate{
    func getValueIndropDown(index: Int, idIndex: Int) {
        switch idIndex {
        case 0:
            btnHospital.setTitle(arr[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnHospital, index: index)
        case 1:
            btnDoctor.setTitle(arr[index], for: .normal)
            MDProvider.instance.changeClTextBtn(btn: btnDoctor, index: index)
        case 2:
            btnTime.setTitle(arr[index], for: .normal)
            if index != 0{
                btnTime.setTitleColor(clTextTitle, for: .normal)
                self.chooseTimeView.view.frame = CGRect(x: -self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
                UIView.animate(withDuration: 0.3, animations: {
                    self.chooseTimeView.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
                }) { (finish) in
                    self.chooseTimeView.setupTimePicker(typeTime: 1)
                }
            }else{
                btnTime.setTitleColor(clDarkTex, for: .normal)
            }
        default:
            print("choose " , index , "on button ", idIndex)
        }
    }
}

extension MakeAppointmentViewController : DoctorPresentDelegate{
    func closeView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.chooseTimeView.view.frame = CGRect(x: -self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + (self.tabBarController?.tabBar.frame.height)! + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0))
        }) { (finish) in
        }
    }
    
    func sendDate(date : String){
        print(date)
        btnTime.setTitle((btnTime.titleLabel?.text)! + " " + date, for: .normal)
    }
}
