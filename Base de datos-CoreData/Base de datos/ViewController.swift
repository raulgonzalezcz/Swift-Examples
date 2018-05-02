//
//  ViewController.swift
//  Base de datos
//
//  Created by UDLAP on 4/2/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //IBOutlets
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var ageField: UITextField!
    
    
    @IBAction func add(_ sender: Any) {
        Model.insertInUsers(username: nameField.text!, age: ageField.text!, password: passwordField.text!)
    }
    
    @IBAction func save(_ sender: Any) {
        Model.save()
        print("Saved to model")
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        Model.deleteAllFromUsers()
    }
    
    
    @IBAction func clean(_ sender: Any) {
        actualizeView("", _aPassword: "", _anAge: "")
    }
    
    func actualizeView(_ aName: String , _aPassword : String, _anAge : String)
    {
        nameField.text = aName
        ageField.text = _anAge
        passwordField.text = _aPassword
    }
    
    func initializeView() {
        actualizeView("", _aPassword: "", _anAge: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.initialize()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


