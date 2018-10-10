//
//  Cell.swift
//  TestLoadMoreTableView
//
//  Created by Macintosh HD on 9/11/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

class Cell: UITableViewCell {
    
    var label: UILabel!
    var width : CGFloat = 0.0
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView.addSubview(label)
        commonInit()
    }
    
    func commonInit() {
        
        self.contentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 50)
        label = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.size.height))
        contentView.addSubview(label)
        label.textAlignment = .center
        label.center = self.contentView.center
        label.font = UIFont(name: label.font.fontName, size: 15)
        contentView.backgroundColor = UIColor(red: 220/255, green: 221/255, blue: 221/255, alpha: 1.0)
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }
}
