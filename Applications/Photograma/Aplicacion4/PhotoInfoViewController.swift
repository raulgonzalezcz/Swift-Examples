//
//  PhotoInfoViewController.swift
//  Aplicacion4
//
//  Created by UDLAP on 3/13/18.
//  Copyright © 2018 Jose Ashamat Jaimes Saavedra. All rights reserved.
//

import Foundation
import UIKit

class PhotoInfoViewController : UIViewController {
    
    var handler : WebServiceCallsHandler!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photo : Photo!{
        didSet{
            navigationItem.title = photo.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler.fetchImage(for: photo, completion:
            {
                    (result) -> Void
                    in
                    switch result{
                    case let .success(image): self.imageView.image = image
                    case let .failure(error): print("Error fetching image for photo : \(error)")
                }
            }
        )
    }
}
