//
//  WebServiceCallsHandler.swift
//  Aplicacion4
//
//  Created by UDLAP on 3/6/18.
//  Copyright © 2018 Jose Ashamat Jaimes Saavedra. All rights reserved.
//

import UIKit
class WebServiceCallsHandler{
    var imageStore = MyImageStore()
    private var photos : [Photo] = []
    
    let urlSession : URLSession = {
        let urlSessionConfiguartion = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguartion)
    }()
    
    func processWebServiceRequest(data: Data?, error: Error?) -> WebServiceResultArrayPhotos{
        guard let jsonData = data
        else{
                return .failure(error!)
        }
        return WebServiceAPI.getWebServiceResult(fromJSON: jsonData)
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (WebServiceResultImage) -> Void){
        var photoKey : String
        var photoURL:URL
        var request: URLRequest
        var urlSessionDataTask: URLSessionDataTask
        
        photoKey = photo.photoID
        if let image = imageStore.getImage(forKey: photoKey){
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
        }
        photoURL = photo.remoteURL
        request = URLRequest(url:photoURL)
        urlSessionDataTask = urlSession.dataTask(with: request){
            (data, responde, error) -> Void
            in
            var imageResult : WebServiceResultImage
            imageResult = self.processImageRequest(data: data, error: error)
            if case let .success(image) = imageResult{
                self.imageStore.setImage(image, forkey: photoKey)
            }
            
            OperationQueue.main.addOperation {
                completion(imageResult)
            }
        }
        urlSessionDataTask.resume()
        }
    
    func processImageRequest(data: Data?, error: Error?) -> WebServiceResultImage{
        guard
        let imageData = data,
            let image = UIImage(data: imageData)
        
            else{
                //Not possible to create an image
                if data == nil{
                    return .failure(error!)
                }
                else{
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
    }
    
    func fetchInterestingPhotos(completion: @escaping (WebServiceResultArrayPhotos) -> Void){
        var url: URL
        var request: URLRequest
        var urlSessionDataTask:URLSessionDataTask
        
        url = WebServiceAPI.interestingPhotoURL
        request = URLRequest(url:url)
        
        urlSessionDataTask = urlSession.dataTask(with: request, completionHandler:{
            (data, response, error) -> Void
            in
            var result : WebServiceResultArrayPhotos
            result = self.processWebServiceRequest(data: data, error:error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        })
        urlSessionDataTask.resume()
    }
}
