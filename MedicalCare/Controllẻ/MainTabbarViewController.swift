//
//  MainTabbarViewController.swift
//  MedicalCare
//
//  Created by Macintosh HD on 9/24/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = clTextTitle
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = clDark
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        // self is Application Delegate
        navigationController?.popToRootViewController(animated: false)
        if (viewController is UINavigationController) {
            (viewController as? UINavigationController)?.popToRootViewController(animated: false)
        }
        
    }

}
