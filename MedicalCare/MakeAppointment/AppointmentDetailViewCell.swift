//
//  AppointmentDetailViewCell.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/28/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

protocol AppointmentDetailDelegate: class {
    func cancelAppointment(idAppointment: Int)
}

class AppointmentDetailViewCell: UITableViewCell {

    @IBOutlet weak var imgAvaDoctor: UIImageView!
    @IBOutlet weak var lblDoctorName: UILabel!
    @IBOutlet weak var lblSpecilize: UILabel!
    @IBOutlet weak var lblHospital: UILabel!
    @IBOutlet weak var lblDateTim: UILabel!
    @IBOutlet weak var tvNote: UITextView!
    @IBOutlet weak var lblFee: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var ctrHeightBtn: NSLayoutConstraint!
    
    weak var delegate : AppointmentDetailDelegate?
    var appointment : AppointmentShow?
    var doctor: DoctorAppoinment?
    var appointmentDoctor : AppointmentDoctorShow?
    var doctorApm : DoctorAppoinmentShow?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func settingShow(appoint: AppointmentShow){
        self.appointment = appoint
        let doctor = self.appointment?.doctor
        let date = self.appointment?.dateBook ?? ""
        let time = self.appointment?.timeBook ?? ""
        
        MDProvider.instance.setupImage(strAva: doctor?.avatar ?? "", imgView: imgAvaDoctor)
        lblDoctorName.text = doctor?.doctor_name ?? ""
        lblSpecilize.text = doctor?.specialize ?? ""
        lblHospital.text = doctor?.hospital ?? ""
        lblDateTim.text = date + " " + time
        tvNote.text = appointment?.problem ?? ""
        lblFee.text = MDProvider.instance.formatPrice(price: appointment?.fee ?? 0)
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }
    
    func settingDoctorApm(appoint: AppointmentDoctorShow){
        self.appointmentDoctor = appoint
        let doctor = self.appointmentDoctor?.doctor
        let date = self.appointmentDoctor?.dateBook ?? ""
        let time = self.appointmentDoctor?.timeBook ?? ""
        
        imgAvaDoctor.image = #imageLiteral(resourceName: "default-avatar")
        lblDoctorName.text = self.appointmentDoctor?.user_name ?? ""
        lblSpecilize.text = doctor?.specialize ?? ""
        lblHospital.text = doctor?.hospital ?? ""
        lblDateTim.text = date + " " + time
        tvNote.text = appointmentDoctor?.problem ?? ""
        lblFee.text = MDProvider.instance.formatPrice(price: appointmentDoctor?.fee ?? 0)
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.reuseIdentifier == "AppointmentDetailViewCell" {
            let status = appointment?.status ?? 0
            
            if status != 0{
                ctrHeightBtn.constant = 0
            }else{
                ctrHeightBtn.constant = 40
            }
        }else if self.reuseIdentifier == "UserAppointmentDetailViewCell" {
            let status = appointmentDoctor?.status ?? 0
            
            if status != 0{
                ctrHeightBtn.constant = 0
            }else{
                ctrHeightBtn.constant = 40
            }
        }
    }
    
    @IBAction func actionCancelAppointment(_ sender: Any) {
        self.delegate?.cancelAppointment(idAppointment: self.appointment?.id ?? 0)
    }
}
