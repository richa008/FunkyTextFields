//
//  CurrencyTextFieldDelegate.swift
//  FunkyTextFields
//
//  Created by Deshmukh,Richa on 5/2/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import Foundation
import UIKit

let maxNumber: Float = 99.99;

class CurrencyTextFieldDelegate : NSObject, UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var newText: String = ""
        var dollars : Float = 0
        
        if let text = textField.text{
            newText = String((text + string).characters.dropFirst())
        }
        let doubleValue = Float(newText)
        if(string != ""){
            if let doubleValue = doubleValue{
                dollars = doubleValue * 10
            }
        }else{
            if let doubleValue = doubleValue{
                dollars = doubleValue / 10
            }
        }
        
        if(dollars < maxNumber){
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            if(string == ""){
                formatter.roundingMode = .RoundDown
            }
            textField.text = formatter.stringFromNumber(NSNumber(float: dollars))
            
        }
        return false
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        textField.text = "$0.00"
        return false;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
