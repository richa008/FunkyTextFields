//
//  CurrencyTextFieldDelegate.swift
//  FunkyTextFields
//
//  Created by Deshmukh,Richa on 5/2/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import Foundation
import UIKit

class CurrencyTextFieldDelegate : NSObject, UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var newText: String = ""
        var dollars : Double = 0
        
        if let text = textField.text{
            newText = String((text + string).characters.dropFirst())
        }
     
        let doubleValue = Double(newText)
        if let doubleValue = doubleValue{
            dollars = doubleValue * 10
        }
        
        if(dollars < 99.99){
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            textField.text = formatter.stringFromNumber(NSNumber(double: dollars))
            
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
