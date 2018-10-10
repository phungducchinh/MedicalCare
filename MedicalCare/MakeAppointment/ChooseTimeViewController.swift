//
//  ChooseTimeViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 10/2/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit



class ChooseTimeViewController: UIViewController {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var pkTime: UIDatePicker!
    weak var delegate : DoctorPresentDelegate?
    var type_time = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pkTime.backgroundColor = .white
        self.viewBg.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.5)
        self.view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewBg.addGestureRecognizer(tap)        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.closeView!()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.delegate?.closeView!()
    }
    
    @IBAction func actionOk(_ sender: Any) {
        self.delegate?.closeView!()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: pkTime.date)
        self.delegate?.sendDate!(date: time)
    }
    
    func setupTime(hour : Int) -> NSDate{
        let startHour: Int = hour
        let date1: NSDate = NSDate()
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        let components: NSDateComponents = gregorian.components(([.day, .month, .year]), from: date1 as Date) as NSDateComponents
        components.hour = startHour
        components.minute = 30
        components.second = 0
        return gregorian.date(from: components as DateComponents)! as NSDate
    }
    
    func setupTimePicker(typeTime : Int){
        pkTime.datePickerMode = .time
        
        if typeTime == 0{
            pkTime.setDate( setupTime(hour: 7) as Date, animated: true)
            pkTime.minimumDate = setupTime(hour: 7) as Date
            pkTime.maximumDate = setupTime(hour: 11) as Date
        }else{
            pkTime.setDate( setupTime(hour: 13) as Date, animated: true)
            pkTime.minimumDate = setupTime(hour: 13) as Date
            pkTime.maximumDate = setupTime(hour: 17) as Date
        }
        pkTime.reloadInputViews()
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
