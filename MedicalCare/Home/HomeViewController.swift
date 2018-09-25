//
//  HomeViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/24/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class HomeViewController: MDBaseViewController {
    
    @IBOutlet weak var colHome: UICollectionView!
    
    var arrImgCell : [UIImage] = [#imageLiteral(resourceName: "img_btn_find_doctor") , #imageLiteral(resourceName: "img_btn_find_hospital") , #imageLiteral(resourceName: "img_btn_pharmacy") , #imageLiteral(resourceName: "img_btn_appointment") , #imageLiteral(resourceName: "img_btn_emergency") , #imageLiteral(resourceName: "img_btn_manage_appointment")]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImgCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.setupCell(idCell: indexPath.row, imgeBtn: arrImgCell[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 161, height: 138)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20)
    }
}

extension HomeViewController : HomeCellDelegate{
    func getIdOfCell(id: Int) {
        print(id)
        
        switch id {
        case 0:
//            self.performSegue(withIdentifier: kSegueHomeToFindDoctor, sender: nil)
            let vc : FindoctorViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindoctorViewController") as! FindoctorViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc : TutorialPageViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TutorialPageViewController") as! TutorialPageViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print(id)
        }
    }
}
