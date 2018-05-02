//
//  ViewController.swift
//  Decoder
//
//  Created by UDLAP05 on 4/24/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let jsonFileName : String = "coordinatesData"
    var codableObject = Location(latide: "3.21", longitu: "4.32")
    
    var boton = UIButton()
    var etiqueta = UILabel()
    var campoTexto = UITextField()
    
    private func showJsonDataArray(_ jsonDataArray : [Any]){
        var dataElement : [String:AnyObject]
        print("Printing JSON Data Array...")
        print("---------------------------")
        for index in jsonDataArray{
            dataElement = index as! [String:AnyObject]
            for (key, value) in dataElement{
                print("Key: \(key) ---> Value: \(value)")
                print()
            }
        }
        print("-----------------")
    }
    
    private func jsonEncoding(codable : Location) -> Data{
        var jsonEncoder : JSONEncoder
        var jsonData : Data
        var jsonString : String?
        
        jsonData = Data()
        jsonEncoder = JSONEncoder()
        do{
            jsonData = try jsonEncoder.encode(codable)
            jsonString = String(data:jsonData, encoding: .utf8)
        }
        catch{
            print("Error while encoding JSON")
        }
        return jsonData
    }
    
    private func jsonDecoding(jsonData : Data) -> Location{
        var jsonDecoder : JSONDecoder
        var stringCoordinates : Location
        
        stringCoordinates = Location()
        
        jsonDecoder = JSONDecoder()
        do{
            stringCoordinates = try jsonDecoder.decode(Location.self, from: jsonData)
            print("Lat:  \(stringCoordinates.latitude)")
            print("Lat:  \(stringCoordinates.longitude)")
            
        }
        catch{
            print("Error while decoding JSON")
        }
        return stringCoordinates
    }

    override func viewDidLoad() {
        var jsonDataArray : [Any]
        var data : Data
        
        super.viewDidLoad()
        
        jsonDataArray = JsonFileReader.read(jsonFileName)
        showJsonDataArray(jsonDataArray)
        
        data = jsonEncoding(codable : codableObject)
        codableObject = jsonDecoding(jsonData : data)
        print(codableObject.description)
        
        boton = DynamicViews.generateButton(fileName: "viewsData")
        etiqueta = DynamicViews.generateLabel(fileName: "viewsData")
        campoTexto = DynamicViews.generateTextField(fileName: "viewsData")
        
        view.addSubview(boton)
        view.addSubview(etiqueta)
        view.addSubview(campoTexto)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

