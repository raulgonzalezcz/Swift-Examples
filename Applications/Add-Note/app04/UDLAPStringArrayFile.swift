//
//  UDLAPStringArrayFile.swift
//  app04
//
//  Created by UDLAP on 11/8/17.
//  Copyright © 2017 UDLAP. All rights reserved.
//

import Foundation
import UIKit

public class UDLAPStringArrayFile
{
    var fileName : String
    var url : URL?
    //
    
    init(_ aFileName : String)
    {
        fileName = aFileName
        url = getURL(fileName)
    }//end constructor
    
    private func getURL(_ fileName : String) -> URL
    {
        var documentDirectoryURLs : [URL]
        var documentDirectoryURL : URL
        //urls() regresa un arreglo de urls correspondiente
        //al directorio comun indicado en el dominio solicitado
        documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //tomamos el primer elemento del arreglo de urls
        documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent(fileName)
    }//end getURL
    
    
    
    func read() -> Array<String>
    {
        var arregloDeDatos : Array<String>
        var nsArray : Array<String>?
        //
        nsArray = NSArray(contentsOf: url!) as? Array<String>
        arregloDeDatos = []
        if (nsArray != nil)
        {
            arregloDeDatos = nsArray!
            nsArray = nil
        }//end if
        return arregloDeDatos
    }//end read
    
    func write(_ array : Array<String>)
    {
        var nsArray = array as NSArray?
        //
        if !(nsArray?.write(to: url!, atomically: true))!
        {
            print("Could not write into file " + fileName)
        }//end if
        nsArray = nil
    }//end write
    
}
