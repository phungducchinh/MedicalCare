//
//  JSON_Distance.swift
//  MedicalCare
//
//  Created by Macintosh HD on 12/23/18.
//  Copyright © 2018 DUCCHINH. All rights reserved.
//

import Foundation
import UIKit

struct JSON_Distance: Codable{
    var destination_addresses: [String]!
    var origin_addresses: [String]!
    var rows: [Element]!
    var status: String!
}//struct

struct Element: Codable {
    var elements: [internalJSON]!
}//struct

struct internalJSON:Codable {
    var distance: DistanceOrTime!
    var duration: DistanceOrTime!
    var status: String!
}//struct

struct DistanceOrTime: Codable {
    var text: String!
    var value: Int!
    
}//struct

