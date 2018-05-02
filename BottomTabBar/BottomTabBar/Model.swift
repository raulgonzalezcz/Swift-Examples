//
//  Model.swift
//  BottomTabBar
//
//  Created by UDLAP on 1/16/18.
//  Copyright © 2018 151211. All rights reserved.
//

import Foundation
class Model{
    static var videos : Array<Video> = []
    static var indiceDelVideoActual = 0
    static var alreadyInitialized = false
    
    static func initialize(){
        var video : Video
        var titulo:String
        var descripcion:String
        var textoURL:String
        var file:UDLAPStringFile
        var i :Int
        
        titulo = ""
        descripcion = ""
        textoURL=""
        i=0
        //
        file = UDLAPStringFile("datos")
        file.open()
        i=0
        while(i<file.size()){
            titulo = file.get(i)!
            descripcion = file.get(i+1)!
            textoURL = file.get(i+2)!
            
            video = Video(titulo, descripcion, textoURL)
            Model.videos.append(video)
            i = i+4
        }
        alreadyInitialized = true
        
    }
}
