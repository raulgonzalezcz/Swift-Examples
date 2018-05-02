//
//  Location.swift
//  Decoder
//
//  Created by UDLAP05 on 4/24/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import Foundation

class Location: Codable, CustomStringConvertible{
    var latitude:String
    var longitude:String
    var description: String {
        return "(\(latitude), \(longitude))"
    }
    
    init(){
        latitude = "0.0"
        longitude = "0.0"
    }
    
    init(latide: String, longitu:String){
        latitude = latide
        longitude = longitu
    }
    
}
