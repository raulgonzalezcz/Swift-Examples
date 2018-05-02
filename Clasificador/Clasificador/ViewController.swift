//
//  ViewController.swift
//  Clasificador
//
//  Created by UDLAP on 2/19/18.
//  Copyright © 2018 151211. All rights reserved.
//

import UIKit
import Vision
import ImageIO
import CoreML

class ViewController: UIViewController {
    
    
    @IBOutlet var imagen: UIImageView!
    @IBOutlet var result: UILabel!
    
    
    @IBAction func clasiffyImage(_ sender: Any) {
        classification(imagen.image!)
    }
    
    func classification(_ image:UIImage){
        var ciImage : CIImage?
        var imageRequestHandler:VNImageRequestHandler
        
        result.text = "Clasificando.."
        
        ciImage = CIImage(image: image)
        imageRequestHandler = VNImageRequestHandler(ciImage: ciImage!, orientation: .up)
        do{
            try imageRequestHandler.perform([self.coreMLResquest])
        }catch{
            print("Failed to perform classification.\n \(error.localizedDescription)")
        }
    }
    
    lazy var requestCompletionHandler : VNRequestCompletionHandler? = {
        [weak self] request, error
        in
        var results : [Any]?
        var classifications : [VNClassificationObservation]
        var topClassifications : ArraySlice<VNClassificationObservation>
        var descriptions : Array<String>
        
        results = request.results
        classifications = results as! [VNClassificationObservation]
        
        topClassifications = classifications.prefix(3)
        
        descriptions = topClassifications.map{
            clase
            in
            return String(format: " (%.2f) %@", clase.confidence, clase.identifier)
        }
        self?.result.text = "classification:\n" + descriptions.joined(separator:"\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    lazy var coreMLResquest : VNCoreMLRequest = {
        var coreMLModel:VNCoreMLModel
        var request:VNCoreMLRequest
        do{
            try coreMLModel = VNCoreMLModel(for: MobileNet().model)
        }catch{
            fatalError("Fail to load Vision ML model: \(error)")
        }
        request = VNCoreMLRequest(model: coreMLModel, completionHandler: requestCompletionHandler)
        request.imageCropAndScaleOption = .centerCrop
        return request
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

