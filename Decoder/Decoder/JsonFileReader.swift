//
//  JsonFileReader.swift
//  Decoder
//
//  Created by UDLAP05 on 4/25/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import Foundation

class JsonFileReader {
    static func read(_ fileName : String) -> [Any]{
        var array : [Any]
        array = []
        print("Reading JSON file...")
        do{
            if let file = Bundle.main.url(forResource : fileName, withExtension : "json"){
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                array = json as! [Any]
            }else{
                print("No file")
            }
        }catch{
            print(error.localizedDescription)
        }
        
        return array
    }
}
