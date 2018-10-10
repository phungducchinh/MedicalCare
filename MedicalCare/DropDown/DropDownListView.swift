//
//  DropDownListView.swift
//  TestLoadMoreTableView
//
//  Created by Macintosh HD on 9/11/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

protocol DropDownDelegate : class {
    func getValueIndropDown(index : Int, idIndex: Int)
}
class DropDownListView :NSObject, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == idHiden{
//            return 0
//        }else{
            return 40
//        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasourceInfo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewDrop.isHidden = true
        self.delegateDrop?.getValueIndropDown(index: indexPath.row, idIndex: idOfCell)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.label.text = datasourceInfo[indexPath.row]
//        if indexPath.row == idHiden{
//            cell.label.textColor = color
//        }else{
//            cell.label.textColor = .black
//        }
        
        if indexPath.row < datasourceInfo.count - 1{
            cell.contentView.layer.borderWidth = 0.5
            cell.contentView.layer.borderColor = UIColor.white.cgColor
        }
        cell.layoutIfNeeded()
        cell.setNeedsLayout()
        return cell
    }
    
    let viewDrop = UIView()
    let bgViewDrop = UIView()
    let tbvDrop = UITableView()
    var datasourceInfo = [String]()
    var widthOfCell : CGFloat = 0.0
    var idOfCell = 0
    
    weak var delegateDrop : DropDownDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    public static var instance = DropDownListView()
    
    func setupDropDown(view : UIView, isScroll : Bool, x: CGFloat, y: CGFloat, width : CGFloat, height : CGFloat, datasource : [String], controller : UIViewController , idCell : Int){
        
        datasourceInfo = datasource
        widthOfCell = width
        delegateDrop = controller as? DropDownDelegate
        idOfCell = idCell
        tbvDrop.isScrollEnabled = isScroll
        let statusFrame = UIApplication.shared.statusBarFrame
        viewDrop.frame = CGRect(x: 0, y: statusFrame.origin.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        bgViewDrop.frame = viewDrop.frame
        bgViewDrop.backgroundColor = .clear
        viewDrop.backgroundColor = .clear
        tbvDrop.frame = CGRect(x: x, y: y, width: width, height: height)
        tbvDrop.backgroundColor = .white
        tbvDrop.separatorStyle = .none
        
//        viewDrop.backgroundColor = .green
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        bgViewDrop.addGestureRecognizer(tap)
        
        tbvDrop.register(Cell.self, forCellReuseIdentifier: "Cell")
        tbvDrop.delegate = self
        tbvDrop.dataSource = self
        tbvDrop.layer.cornerRadius = 3
        tbvDrop.bouncesZoom = false
        tbvDrop.bounces = false
        tbvDrop.scrollToTop(animated: false)
        
        viewDrop.addSubview(bgViewDrop)
        viewDrop.addSubview(tbvDrop)
        viewDrop.isHidden = false
        UIApplication.shared.windows.last?.addSubview(viewDrop)
        DispatchQueue.main.async {
           self.tbvDrop.reloadData()
            self.tbvDrop.layoutIfNeeded()
            self.tbvDrop.setNeedsLayout()
            self.tbvDrop.reloadData()
        }
       
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        viewDrop.isHidden = true
    }
    
    func hideDropDown(){
        viewDrop.isHidden = true
    }
    
    override init() {
        
    }
}
