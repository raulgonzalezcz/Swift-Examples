//
//  ViewController.swift
//  ServerMam
//
//  Created by UDLAP on 4/16/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataText: UITextField!
    
    
    @IBOutlet weak var oldValue: UITextField!
    
    
    @IBOutlet weak var newValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func update(_ sender: Any) {
        Model.post(urlPHPFile: "http://localhost:8888/update.php", oldData: oldValue.text!, newData: newValue.text!)
    }
    
    
    @IBAction func insert(_ sender: Any) {
        Model.post(urlPHPFile: "http://localhost:8888/insert.php", data: dataText.text!)
    }
    
    
    @IBAction func showAll(_ sender: Any) {
        Model.selectAll(urlPHPFile: "http://localhost:8888/selectAll.php"){
            resultSet in
            Model.dataStructure = resultSet
            print(Model.dataStructure)
        }
    }
    
    
    @IBAction func deleteThis(_ sender: Any) {
        Model.post(urlPHPFile: "http://localhost:8888/delete.php", data: dataText.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

