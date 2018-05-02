//
//  ViewController.swift
//  app04
//
//  Created by UDLAP on 11/8/17.
//  Copyright © 2017 UDLAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    ///////Properties
    
    var tableViewDataSource : MyTableViewDataSource? = nil
    
    ///////IBOutlets
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    ///////IBActions
    
    @IBAction func onClickAddNoteButton(_ sender: UIButton)
    {
        guard let nota = itemTextField.text else
        {
            return
        }//end guard else
        Model.add(nota)
        updateView()
    }//end onClickAddNoteButton
    
    @IBAction func onClickCleanButton(_ sender: UIButton)
    {
        Model.removeAll()
        updateView()
    }//end onClickCleanButton
    
    ///////Methods
    
    func initializeView()
    {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "nota")
        tableViewDataSource = MyTableViewDataSource("nota")
        tableView.dataSource = tableViewDataSource
    }//end initializeView
    
    func updateView()
    {
        itemTextField.text = ""
        tableView.reloadData()
    }//end updateView

    override func viewDidLoad() {
        var tapGestureRecognizer : UITapGestureRecognizer
        //
        super.viewDidLoad()
        Model.initialize()
        initializeView()
        //
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }//end viewDidLoad
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }//end dismissKeyboard

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

