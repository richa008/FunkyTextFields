//
//  ColorDetectingTextFieldDelegate.swift
//  FunkyTextFields
//
//  Created by Deshmukh,Richa on 4/29/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import Foundation
import UIKit

class ColorizerTextFieldDelegate: NSObject, UITextFieldDelegate{
    
    let colors : [String : UIColor] = [
        "red": UIColor.redColor(),
        "orange":  UIColor.orangeColor(),
        "yellow":  UIColor.yellowColor(),
        "green":  UIColor.greenColor(),
        "blue":  UIColor.blueColor(),
        "brown":  UIColor.brownColor(),
        "black":  UIColor.blackColor(),
        "purple":  UIColor.purpleColor(),
        "cyan" : UIColor.cyanColor(),
        "magenta" : UIColor.magentaColor(),
        "white" : UIColor.whiteColor()
    ]

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var colorsInText = [UIColor](), newText : NSString = ""
        if let text = textField.text{
            newText = text as NSString
        }
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        for(colorString, color) in colors{
            let colorStringRange : NSRange = newText.rangeOfString(colorString, options: NSStringCompareOptions.CaseInsensitiveSearch)
            if(colorStringRange.location != NSNotFound){
                colorsInText.append(color)
            }
        }
        
        if colorsInText.count > 0 {
            textField.textColor = self.blendColorArray(colorsInText)
        }
        
        return true
    }
    
    func blendColorArray(colors: [UIColor]) -> UIColor {
        var colorComponents: [CGFloat] = [CGFloat](count: 4, repeatedValue: 0.0)
        
        for color in colors {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            colorComponents[0] += red
            colorComponents[1] += green
            colorComponents[2] += blue
            colorComponents[3] += alpha
        }
        
        for i in 0...colorComponents.count - 1 {
            colorComponents[i] /= CGFloat(colors.count)
        }
        
        return UIColor(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2], alpha: colorComponents[3])
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}