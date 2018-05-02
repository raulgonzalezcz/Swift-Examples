//
//  Model.swift
//  Base de datos
//
//  Created by UDLAP on 4/4/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//
import UIKit
import CoreData
import Foundation

public class Model{
    static var managedObjectContext:NSManagedObjectContext? = nil
    static var entityDescription: NSEntityDescription? = nil
    static var fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    
    static func initialize(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        entityDescription = NSEntityDescription.entity(forEntityName: "Users", in: managedObjectContext!)
    }
    
    static func selectAllFromUsers()->Array<Users>{
        var arrayOfManagedObjects: Array<Users>
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        fetchRequest.returnsObjectsAsFaults = false
        arrayOfManagedObjects = executeFetch()
        return arrayOfManagedObjects
    }
    
    static func selectAllFromUsers(orderBy: String)->Array<Users>{
        var sortDescriptor : NSSortDescriptor
        var sortDescriptors:Array<NSSortDescriptor>
        var arrayOfManagedObjects: Array<Users>
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        fetchRequest.returnsObjectsAsFaults = false
        //Sort descriptor
        sortDescriptor = NSSortDescriptor(key:orderBy, ascending:true)
        sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        arrayOfManagedObjects = executeFetch()
        return arrayOfManagedObjects
    }
    
    static func executeFetch() -> Array<Users>{
        var arrayObjectContext : Array<Users>
        arrayObjectContext = []
        do{
            arrayObjectContext = (try managedObjectContext?.fetch(Model.fetchRequest))! as! Array<Users>
            return arrayObjectContext
        }catch{
            print("Failed")
        }
        return arrayObjectContext
    }
    
    static func selectAllFromUsersWhere(username : String)->Array<Users>{
        var arrayOfManagedObjects: Array<Users>
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        arrayOfManagedObjects = executeFetch()
        return arrayOfManagedObjects
    }
    
    static func selectTop1FromUsersWhere(username : String)-> Users{
        var arrayOfManagedObjects: Array<Users>
        var firstObject:Users
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        //Just one object
        fetchRequest.fetchLimit = 1
        arrayOfManagedObjects = executeFetch()
        firstObject = arrayOfManagedObjects.first!
        return firstObject
    }
    
    //We create a Managed Object (Data in Object Manager Context)
    static func insertInUsers(username:String, age:String, password: String){
        var managedObject : NSManagedObject
        entityDescription = NSEntityDescription.entity(forEntityName: "Users", in: managedObjectContext!)
        managedObject = NSManagedObject(entity: entityDescription!, insertInto:managedObjectContext)
        managedObject.setValue(username, forKey: "username")
        
        managedObject.setValue(Int(age), forKey: "age")
        
        managedObject.setValue(password, forKey: "password")
        
    }
    
    static func deleteAllFromUsers(){
        var arrayOfManagedObjects:Array<Users>
        arrayOfManagedObjects = selectAllFromUsers()
        //Remove
        for object in arrayOfManagedObjects{
            managedObjectContext?.delete(object)
        }
    }
    
    static func deleteAllFromUsersWhere(username: String){
        var managedObject:Users
        managedObject = selectTop1FromUsersWhere(username: username)
        managedObjectContext?.delete(managedObject)
        
    }
    
    static func save(){
        do{
            try managedObjectContext?.save()
        }catch{
            print("Failed saving")
        }
    }
    
}
