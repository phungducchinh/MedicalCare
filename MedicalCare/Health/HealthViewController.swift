//
//  HealthViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 11/30/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit
import HealthKit

class HealthViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var tbHealth: UITableView!
    @IBOutlet weak var bgView: UIView!
    
    var isStart = true;
    var workoutConfiguration = HKWorkoutConfiguration();
    let healthStore = HKHealthStore(); //khai báo
    var nbFloor = 0.0
    var nbWalk = 0.0
    var nbDistance = 0.0
    var arrRealData : [Double] = [0,0,0]
    var arrTitle = ["Quãng đường đi + chạy","Số bước chân","Số tầng đã leo"]
    var arrInfo : [String] = ["3200 m","10000 bước","5 tầng"]
    var arrNumberInfo : [Double] = [1000,10000,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Thông tin sức khoẻ"
        MDProvider.instance.setUpNavigation(controller: self)
        tbHealth.rowHeight = UITableViewAutomaticDimension
        MDProvider.instance.setGradientBackground(view: self.bgView)
//        MDProvider.instance.setShadown(view: tbHealth, borderShadow: 1.0, bgColor :.clear, shadownColor : .black)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.requestPermission()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(nbDistance, " ", nbWalk, " ", nbFloor )
        DispatchQueue.main.async {
            self.tbHealth.reloadData()
            self.lblInfo.text = "\(Double((self.arrRealData[0]/self.arrNumberInfo[0] + self.arrRealData[1]/self.arrNumberInfo[1] + self.arrRealData[2]/self.arrNumberInfo[2])/3).roundToDecimal(1)) %"
        }
    }
    
    func requestPermission(){
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        guard let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
            let gender = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let leanBodyMass = HKObjectType.quantityType(forIdentifier: .leanBodyMass),
            let activityEnergyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)else {return}
        
        guard let bodyMassIndex =  HKSampleType.quantityType(forIdentifier: .bodyMassIndex),
            let energyBurned = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned),
            let distance = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning),
            let floor = HKSampleType.quantityType(forIdentifier: .flightsClimbed)else {return}
        
        //xin quyền read giá trị trong array
        let readDataTypes: Set<HKObjectType> = [dateOfBirth, bloodType, gender, bodyMass, height,leanBodyMass, HKObjectType.workoutType(), activityEnergyBurned, stepCount,distance, energyBurned,floor ];
        
        //xin quyền save giá trị trong array
        let writeDataTypes: Set<HKSampleType> = [bodyMassIndex, energyBurned, distance, HKSampleType.workoutType()] ;
        
        healthStore.requestAuthorization(toShare: writeDataTypes, read: readDataTypes) { (result, error) in
            if result{
                self.setUp()
            }
        }
    }
    
    func setUp(){
        //get string cho từng giá trị: height, bodyMass
        
        self.fetchCountStep(); //fetch đếm số bước chân từ ngày startDate đến ngày currentDate
        self.getNumberFloorWalk()
        self.getDistanceWalk()
        /*var double = 0.0
        getTodaysSteps(completion: {result in
            double = result
            print(result, " ", double)
        })*/
    }

    func fetchCountStep(){ // số bước chân
        _ = Locale.init(identifier: "vi_VN")
        let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        let endDate = Date()
        let lastValue = HKQuery.predicateForSamples(withStart: startDate as Date,
                                                    end: endDate as Date,
                                                    options: .strictStartDate);
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        guard let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount) else {
            return;
        }
        
        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: lastValue,
                                  limit: 0,
                                  sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error ) -> Void in
                                    
                                    guard let results = results else {return}
                                    
                                    var step: Double = 0;
                                    for result in results {
                                        if let result = result as? HKQuantitySample{
                                            step  += result.quantity.doubleValue(for: HKUnit.count());
                                        }
                                    }
                                    
                                    DispatchQueue.main.sync {
                                        self.nbWalk = step
                                        self.arrRealData[1] = step
                                    }
        }
        
        self.healthStore.execute(query);
    }
    
    func getNumberFloorWalk(){ // số tầng đã leo
        _ = Locale.init(identifier: "vi_VN")
        let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        let endDate = Date()
        let lastValue = HKQuery.predicateForSamples(withStart: startDate as Date,
                                                    end: endDate as Date,
                                                    options: .strictStartDate);
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        guard let sampleType = HKSampleType.quantityType(forIdentifier: .flightsClimbed) else {
            return;
        }
        
        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: lastValue,
                                  limit: 0,
                                  sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error ) -> Void in
                                    
                                    guard let results = results else {return}
                                    
                                    var step: Double = 0;
                                    for result in results {
                                        if let result = result as? HKQuantitySample{
                                            step  += result.quantity.doubleValue(for: HKUnit.count());
                                        }
                                    }
                                    
                                    DispatchQueue.main.sync {
                                        self.nbFloor = step
                                        self.arrRealData[2] = step
                                    }
        }
        
        self.healthStore.execute(query);
    }
    
    func getDistanceWalk() { // quảng đường đi được
        let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        let endDate = Date()
        
        print("Collecting workouts between \(startDate) and \(endDate)")
        let lastValue = HKQuery.predicateForSamples(withStart: startDate as Date,
                                                    end: endDate as Date,
                                                    options: .strictStartDate);
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        guard let sampleType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return;
        }
        
        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: lastValue,
                                  limit: 0,
                                  sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error ) -> Void in
                                    
                                    guard let results = results else {return}
                                    
                                    var step: Double = 0;
                                    for result in results {
                                        if let result = result as? HKQuantitySample{
                                            step  += result.quantity.doubleValue(for: HKUnit.meter());
                                        }
                                    }
                                    
                                    DispatchQueue.main.sync {
                                        self.nbDistance = step
                                        self.arrRealData[0] = step
                                    }
        }
        
        self.healthStore.execute(query);
    }
    /*
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }*/
    

}

extension HealthViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthTableViewCell", for: indexPath) as! HealthTableViewCell
        cell.setupData(title: arrTitle[indexPath.row], info: arrInfo[indexPath.row], progress: self.arrRealData[indexPath.row]/arrNumberInfo[indexPath.row], id: indexPath.row, safe: 40)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
}
