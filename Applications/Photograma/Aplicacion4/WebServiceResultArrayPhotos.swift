//
//  WebServiceResultArrayPhotos.swift
//  Aplicacion4
//
//  Created by UDLAP on 3/6/18.
//  Copyright © 2018 Jose Ashamat Jaimes Saavedra. All rights reserved.
//

import Foundation
enum WebServiceResultArrayPhotos{
    case success([Photo])
    case failure(Error)
}
