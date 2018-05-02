//
//  WebServiceAPI.swift
//  Aplicacion4
//
//  Created by UDLAP on 3/6/18.
//  Copyright © 2018 Jose Ashamat Jaimes Saavedra. All rights reserved.
//

import Foundation
enum Method: String{
    case interestingPhotosURIMethod = "flickr.interestingness.getList"
}

enum WebServiceError: Error{
    case invalidJSONData
}

public class WebServiceAPI{
    private static let webServiceURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "a6d819499131071f158fd740860a5a88"
    
    private static let dateFormatter:DateFormatter={
        var formatter:DateFormatter
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static var interestingPhotoURL: URL{
        return getURL(uriMethod: Method.interestingPhotosURIMethod, parameters: ["extras":"url_h,date_taken"])
    }
    
    private static func getURL(uriMethod: Method, parameters: [String:String]?)->URL{
        var components:URLComponents
        var queryItems:[URLQueryItem]
        var urlQueryItem:URLQueryItem
        let baseParameters=[
            "method": uriMethod.rawValue,
            "format":"json",
            "nojsoncallback":"1",
            "api_key":apiKey
        ]
        
        components = URLComponents(string: webServiceURLString)!
        queryItems = [URLQueryItem]()
        
        for(key,value) in baseParameters{
            urlQueryItem = URLQueryItem(name: key, value: value)
            queryItems.append(urlQueryItem)
        }
        
        if let additionalParams = parameters{
            for (key,value) in additionalParams{
                urlQueryItem = URLQueryItem(name: key, value:value)
                queryItems.append(urlQueryItem)
            }
        }
        components.queryItems=queryItems
        return components.url!
    }
    
    static func getWebServiceResult(fromJSON data: Data)->WebServiceResultArrayPhotos{
        var jsonObject : Any
        var finalPhotos: [Photo]
        var result : WebServiceResultArrayPhotos
        
        do{
            jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
            let jsonDictionary = jsonObject as? [AnyHashable:Any],
            let photos = jsonDictionary["photos"] as? [String:Any],
            let photosArray = photos["photo"] as? [[String:Any]]
                else{
                    return .failure(WebServiceError.invalidJSONData)
            }
            
            finalPhotos = Array<Photo>()
            for photoJSON in photosArray{
                if let photo = getPhoto(fromJSON : photoJSON){
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.isEmpty && !photosArray.isEmpty{
                //We arent able to parse any of the photos
                //Maybe the JSON format for photos has changed
                result = .failure(WebServiceError.invalidJSONData)
            }else{
                result = .success(finalPhotos)
            }
            
        }
        catch let error{
            result = .failure(error)
        }
        return result
    }
    
    private static func getPhoto(fromJSON json: [String:Any]) -> Photo?{
        guard
        let photoID = json["id"] as? String,
        let title = json["title"] as? String,
        let dateString = json["datetaken"] as? String,
        let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormatter.date(from:dateString)
            else{
                return nil
        }
        return Photo(title:title, photoID: photoID, remoteURL:url, dateTaken: dateTaken)
    }
}
