//
//  Model.swift
//  ServerMam
//
//  Created by UDLAP on 4/16/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import Foundation
class Model {
    static var dataStructure : [String] = []
    
    static func post(urlPHPFile:String, data:String){
        var nsMutableURLRequest : NSMutableURLRequest
        var postParameter : String
        var urlSessionDataTask : URLSessionDataTask
        
        nsMutableURLRequest = NSMutableURLRequest(url: NSURL(string:urlPHPFile)! as URL)
        nsMutableURLRequest.httpMethod = "POST"
        postParameter = "parameter=\(data)"
        nsMutableURLRequest.httpBody = postParameter.data(using : String.Encoding.utf8)
        urlSessionDataTask = URLSession.shared.dataTask(with: nsMutableURLRequest as URLRequest){
            (nsData, urlResponse, nsError) in
            if nsError != nil{
                print("Error : \(String(describing: nsError))")
            }
        }
        urlSessionDataTask.resume()
    }
    
    static func post(urlPHPFile:String, oldData:String, newData:String){
        
        var nsMutableRequest : NSMutableURLRequest
        var postParameter:String
        var urlSessionDataTask : URLSessionDataTask
        
        nsMutableRequest = NSMutableURLRequest(url:NSURL (string:urlPHPFile)! as URL)
        nsMutableRequest.httpMethod = "POST"
        postParameter = "parameter1=\(oldData)&parameter2=\(newData)"
        nsMutableRequest.httpBody = postParameter.data(using: String.Encoding.utf8)
        urlSessionDataTask = URLSession.shared.dataTask(with: nsMutableRequest as URLRequest){
            (nsData, urlResponse, nsError) in
            if nsError != nil{
                print("Update error:\(String(describing: nsError))")
            }
        }
        urlSessionDataTask.resume()
        
    }
    
    static func selectAll(urlPHPFile : String, completion: @escaping (Array<String>) -> () ){
        var urlSessionDataTask : URLSessionDataTask
        var JSONDecodedData : Array<Dato> = []
        var resultSet : Array<String> = []
        
        guard let url = URL(string:urlPHPFile)
            else{
                return
        }
        
        //We create a URL session data task that retrieves the contents of especified URL
        urlSessionDataTask = URLSession.shared.dataTask(with: url){
            (nsData, URLResponse, nsError)
            in
            guard let selectedData = nsData
                else{
                    return
            }
            do{
                JSONDecodedData = try JSONDecoder().decode(Array<Dato>.self, from: selectedData)
                print("JSON decoded data: ", JSONDecodedData)
                for element in JSONDecodedData{
                    resultSet.append(element.myColumn!)
                }
                completion(resultSet)
            }
            catch{
                print("Error decoding JSON")
            }
        }
        urlSessionDataTask.resume()
    }
    
}
