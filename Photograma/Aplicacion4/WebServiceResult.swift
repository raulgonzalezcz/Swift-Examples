//
//  WebServiceResult.swift
//  Aplicacion4
//
//  Created by UDLAP on 3/5/18.
//  Copyright © 2018 Jose Ashamat Jaimes Saavedra. All rights reserved.
//

import Foundation
enum WebServiceResult{
    case success([Photo])
    case failure(Error)
}
