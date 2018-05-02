//
//  Video.swift
//  BottomTabBar
//
//  Created by UDLAP on 1/16/18.
//  Copyright © 2018 151211. All rights reserved.
//

import Foundation
class Video {
    private var titulo:String
    private var descripcion:String
    private var urlString:String
    private var url:URL
    
    init(_ unTitulo:String,_ unaDescripcion:String,_ unaURL:String) {
        titulo = unTitulo
        descripcion = unaDescripcion
        urlString = unaURL
        url = URL(string: urlString)!
    }
    
    func getTitulo()->String{
        return titulo
    }
    
    func getDescripcion()->String{
        return descripcion
    }
    
    func getURLsString() -> String{
        return urlString
    }
}
