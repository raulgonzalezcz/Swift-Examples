//
//  DynamicViews.swift
//  Decoder
//
//  Created by UDLAP05 on 4/26/18.
//  Copyright © 2018 UDLAP. All rights reserved.
//

import Foundation
import UIKit
class DynamicViews{
    static var red: Double = Double()
    static var green: Double = Double()
    static var blue: Double = Double()
    static var alpha: Double = Double()
    
    static var x: Double = Double()
    static var y: Double = Double()
    static var width: Double = Double()
    static var height: Double = Double()
    
    static var title: String = String()
    
    static func convertToDictionary(){
        
    }
    
    private static func getViewComponentsArray(forResource:String, withExtension:String) -> [Any]{
        var data:Data
        var jsonObject:Any
        var viewComponentsArray:[Any]?
        //
        viewComponentsArray = nil
        do
        {
            if let url = Bundle.main.url(forResource: forResource, withExtension: withExtension){
                data = try Data(contentsOf:url)
                jsonObject=try JSONSerialization.jsonObject(with: data, options: [])
                viewComponentsArray = jsonObject as? [Any]
            }
            else{
                print("Invalid JSON")
            }
        }
        catch{
            print(error.localizedDescription)
        }
        return viewComponentsArray!
    }
    
    public static func getUIColor(_ dictionary:[String:Double]) -> UIColor{
        var uicolor:UIColor
        uicolor = UIColor()
        if let redValue = dictionary["r"]{
            red = redValue
        }
        if let greenValue = dictionary["g"]{
            green = greenValue
        }
        if let blueValue = dictionary["b"]{
            blue = blueValue
        }
        if let alphaValue = dictionary["alpha"]{
            alpha = alphaValue
        }
        uicolor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        return uicolor
    }
    
    public static func getCGRect(_ dictionary:[String:Double]) -> CGRect{
        var cgrect : CGRect
        cgrect = CGRect()
        if let xPosition = dictionary["x"]{
            DynamicViews.x = xPosition
        }
        if let yPosition = dictionary["y"]{
            DynamicViews.y = yPosition
        }
        if let widthDimension = dictionary["width"]{
            DynamicViews.width = widthDimension
        }
        if let heightDimension = dictionary["height"]{
            DynamicViews.height = heightDimension
        }
        cgrect = CGRect(x: DynamicViews.x, y: DynamicViews.y, width: DynamicViews.width, height: DynamicViews.height)
        return cgrect
    }
    
    public static func generateButton(fileName:String) -> UIButton {
        var viewComponentsArray : [Any]
        var dictionary : [String:AnyObject] = [:]
        var numericalValuesDictonary : [String:Double]?
        var cgrect:CGRect
        var uicolor:UIColor
        var button:UIButton
        var hidden:Bool = Bool()
        var focused:Bool = Bool()
        var i:Int
        
        viewComponentsArray = getViewComponentsArray(forResource: fileName, withExtension: "json")
        i = 0
        while(i < viewComponentsArray.count){
            dictionary = viewComponentsArray[i] as! [String:AnyObject]
            numericalValuesDictonary = dictionary["UIButton_double_values"] as? [String:Double]
            i = i + 1
        }
        cgrect = getCGRect(numericalValuesDictonary!)
        button = UIButton(frame:cgrect)
        
        uicolor = getUIColor(numericalValuesDictonary!)
        button.backgroundColor = uicolor
        
        if let buttonTitle = dictionary["title"] as? String{
            title = buttonTitle
        }
        button.setTitle(title, for: .normal)
        
        if let isHidden = dictionary["hidden"] as? Bool{
            hidden = isHidden
        }
        button.isHidden = hidden
        
        if let isFocused = dictionary["focused"] as? Bool{
            focused = isFocused
        }
        button.isEnabled = focused
        return button
        
    }
    
    public static func generateLabel(fileName:String) -> UILabel {
        var viewComponentsArray : [Any]
        var dictionary : [String:AnyObject] = [:]
        var numericalValuesDictonary : [String:Double]?
        var cgrect:CGRect
        var uicolor:UIColor
        var label:UILabel
        
        viewComponentsArray = getViewComponentsArray(forResource: fileName, withExtension: "json")
        for index in 0...viewComponentsArray.count - 1{
            dictionary = viewComponentsArray[index] as! [String:AnyObject]
            numericalValuesDictonary = dictionary["UILabel"] as? [String:Double]
            
        }
        cgrect = getCGRect(numericalValuesDictonary!)
        label = UILabel(frame:cgrect)
        
        uicolor = getUIColor(numericalValuesDictonary!)
        label.backgroundColor = uicolor
        
        if let labelTitle = dictionary["title_label"] as? String{
            title = labelTitle
        }
        label.text = title
        label.textColor = UIColor(red:0.0, green:0.0, blue:0.502, alpha:1.0)
        return label
        
    }
    
    public static func generateTextField(fileName:String) -> UITextField {
        var viewComponentsArray : [Any]
        var dictionary : [String:AnyObject] = [:]
        var numericalValuesDictonary : [String:Double]?
        var cgrect:CGRect
        var uicolor:UIColor
        var textfield:UITextField
        var i:Int
        
        viewComponentsArray = getViewComponentsArray(forResource: fileName, withExtension: "json")
        i = 0
        while(i < viewComponentsArray.count){
            dictionary = viewComponentsArray[i] as! [String:AnyObject]
            numericalValuesDictonary = dictionary["UITextField"] as? [String:Double]
            i = i + 1
        }
        cgrect = getCGRect(numericalValuesDictonary!)
        textfield = UITextField(frame:cgrect)
        
        uicolor = getUIColor(numericalValuesDictonary!)
        textfield.backgroundColor = uicolor
        textfield.autocorrectionType = UITextAutocorrectionType.no
        textfield.keyboardType = UIKeyboardType.default
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.clearButtonMode = UITextFieldViewMode.whileEditing
        textfield.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textfield.isEnabled = true
        textfield.isUserInteractionEnabled = true
        textfield.delegate = self as? UITextFieldDelegate
        textfield.placeholder = "Placeholder"
        
        return textfield
        
    }
    
}
