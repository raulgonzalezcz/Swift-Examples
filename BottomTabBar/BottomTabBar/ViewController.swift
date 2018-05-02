//
//  ViewController.swift
//  BottomTabBar
//
//  Created by UDLAP on 1/16/18.
//  Copyright © 2018 151211. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //IBOutlets
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var textView: UITextView!
    
    //Variables
    var pickerViewDataSource : Array<String> = []
    
    func initializeView(){
        print(Model.videos.count)
        for video in Model.videos{
            print(video.getTitulo())
            pickerViewDataSource.append(video.getTitulo())
        }
        textView.text = Model.videos[0].getDescripcion()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!Model.alreadyInitialized){
            Model.initialize()
        }
        initializeView()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView(index : Int){
        textView.text = Model.videos[index].getDescripcion()
    }
    
    func updateModel(index: Int){
        Model.indiceDelVideoActual = index
    }
    
    //Delegates:
    //Al implementar UIPickerViewDataSource, debemos poner
    func numberOfComponents(in: UIPickerView)->Int{
        return 1
    }
    
    //Al implementar UIPickerViewDataSource, debemos poner
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int)->Int{
        return pickerViewDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewDataSource[row]
    }
    
    //UIPickerViewDelegate methods
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateView(index: row)
        updateModel(index: row)
    }
}

