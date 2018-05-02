//
//  MyTableViewDataSource.swift
//  app04
//
//  Created by UDLAP on 11/10/17.
//  Copyright © 2017 UDLAP. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewDataSource : NSObject, UITableViewDataSource
{
    var cellID : String
    //
    
    init(_ aCellID : String)
    {
        cellID = aCellID
    }//end init
    
    //Para cumplir con el protocolo
    
    //proporciona el numero de renglones
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Model.arregloDeDatos.count
    }//end tableView
    
    //proporcion la celda de clase UITableViewCell correspondiente a su indice (renglon)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var celda : UITableViewCell
        var dato : String
        //obtenemos una celda reusable
        celda = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        dato = Model.arregloDeDatos[indexPath.row]
        celda.textLabel!.text = dato
        return celda
    }//end tableView
}//end MyTableViewDataSource
