//
//  Model.swift
//  Aplicacion02
//
//  Created by UDLAP on 1/29/18.
//  Copyright © 2018 Udlap. All rights reserved.
//

import Foundation
class Model{
    static var items: Array<Item> = []
    
    static func addItem(_ item:Item){
        items.append(item)
    }
    
    static func removeItem(_ item:Item){
        if let index = items.index(of: item){
            items.remove(at: index)
        }
    }
    
    static func moveItem(fromIndex:Int, toIndex: Int){
        var movedItem:Item
        if fromIndex != toIndex {
            //Get reference to object being moved so you can re-insert it
            movedItem = items[fromIndex]
            //Remove item from array
            items.remove(at: fromIndex)
            //Insert item in array at new location
            items.insert(movedItem, at: toIndex)
        }
    }
}
