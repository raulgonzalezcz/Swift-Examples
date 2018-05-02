//
//  QueryViewController.swift
//  Base de datos
//
//  Created by UDLAP on 4/4/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import Foundation
import  UIKit
class QueryViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBAction func makeQuery(_ sender: Any) {
        
        var object: Users!
        
        object = Model.selectTop1FromUsersWhere(username: nameField.text!)
        let age = String(describing: object.value(forKey: "age")!)
        ageField.text = age
        passwordField.text = object.value(forKey: "password") as? String
        
    }
    
    @IBAction func deleteThis(_ sender: Any) {
        
        Model.deleteAllFromUsersWhere(username: nameField.text!)
    }
    
    @IBAction func showAll(_ sender: Any) {
        
        var resultSet : [Users]
        
        resultSet = Model.selectAllFromUsers()
        print("Number of records")
        print(resultSet.count)
        print("===")
        for object in resultSet{
            print(object.value(forKey: "username") as! String )
            print(object.value(forKey: "age") as! Int)
            
            print(object.value(forKey: "password") as! String)
            print("===")
        }
        print("End iterator")
        
        
    }
    
    @IBAction func showAllSorted(_ sender: Any) {
        var resultSet : [Users]
        
        resultSet = Model.selectAllFromUsers(orderBy: "username")
        print(resultSet)
        
        
    }
    
    @IBAction func showResultSet(_ sender: Any) {
        
        var resultSet : Array<Users>
        resultSet = Model.selectAllFromUsersWhere(username: nameField.text!)
        printResultSet(resultSet)
        
        
    }
    
    private func printResultSet(_ resultSet: Array<Users>) {
        
        print("Number of records!")
        print(resultSet.count)
        print("======")
        for object in resultSet {
            print(object.value(forKey: "username") as! String)
            
            print(object.value(forKey: "age") as! Int)
            
            print(object.value(forKey: "password") as! String)
        }
        
    }
    
    
}
