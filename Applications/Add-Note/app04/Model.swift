//
//  Model.swift
//  app04
//
//  Created by UDLAP on 11/8/17.
//  Copyright © 2017 UDLAP. All rights reserved.
//

import Foundation

class Model
{
    static var arrayFile : UDLAPStringArrayFile?
    static var arregloDeDatos : Array<String> = []
    //
    
    static func initialize()
    {
        //podemos usar cualquier nombre y cualquier sufijo
        Model.arrayFile = UDLAPStringArrayFile("misNotas")
        
        //le pide a arrayFile a leer el contenido del archivo y lo coloca en arregloDeDatos
        Model.arregloDeDatos = (arrayFile?.read())!
    }//end initialize
    
    static func add(_ nota: String)
    {
        arregloDeDatos.append(nota)
        Model.arrayFile?.write(arregloDeDatos)
    }//end add
    
    static func removeAll()
    {
        arregloDeDatos = []
        Model.arrayFile?.write(arregloDeDatos)
    }//end removeAll
}//end Model
