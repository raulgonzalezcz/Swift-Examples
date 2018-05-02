//
//  ViewController.swift
//  Aplicacion02
//
//  Created by Udlap on 1/22/18.
//  Copyright © 2018 Udlap. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    //IBActions
    @IBAction func addNewItem(_ sender: Any) {
        var newItem : Item
        var indexPath : IndexPath
        
        newItem = Item()
        Model.addItem(newItem)
        
        if let index = Model.items.index(of: newItem){
            indexPath = IndexPath(row: index, section:0)
            tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeView()
    }
    
    func initializeView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem"?:
            //Celda seleccionada
            if let row = tableView.indexPathForSelectedRow?.row{
                //Obtenemos el item asociado
                let item = Model.items[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    //Override UITableViewController
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        Model.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var item:Item
        var title:String
        var alertController:UIAlertController
        var cancelAction:UIAlertAction
        var deleteAction:UIAlertAction
        
        //If the table view is asking to commit a delete command...
        if editingStyle == UITableViewCellEditingStyle.delete{
            item = Model.items[indexPath.row]
            title = "Delete \(item.name)?"
            alertController = UIAlertController(title: title, message: "Are you sure you want to delete this item?", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            
            deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { (action) -> Void in Model.removeItem(item)
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            })
            alertController.addAction(deleteAction)
            
            //Present the Controller
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ItemCell
        var item:Item
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        item = Model.items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.serialNumber.text = item.serialNumber
        cell.valueLabel.text = "$\(item.value)"
        
        return cell
    }

}

