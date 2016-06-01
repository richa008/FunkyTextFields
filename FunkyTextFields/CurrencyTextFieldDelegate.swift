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
        
        let maxNumberLength = 12
        
        let currencyFormattor = NSNumberFormatter()
        currencyFormattor.numberStyle = .CurrencyStyle
        currencyFormattor.minimumFractionDigits = 2
        currencyFormattor.maximumFractionDigits = 2
        
        let textFieldString = textField.text
        let textFieldLength = textFieldString?.characters.count
        var cursorPosition : Int = 0
        let startPosition : UITextPosition = textField.beginningOfDocument
        if let selectedTextRange = textField.selectedTextRange{
            
            cursorPosition = textField.offsetFromPosition(startPosition, toPosition: selectedTextRange.start)
        }

        
        var replacedNumberString: String = ""
        
        //Remove $
        if let textFieldString = textFieldString{
            replacedNumberString = (textFieldString as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            var toArray = replacedNumberString.componentsSeparatedByString("$")
            replacedNumberString = toArray.joinWithSeparator("")
            
            toArray = replacedNumberString.componentsSeparatedByCharactersInSet(NSCharacterSet .punctuationCharacterSet())
            replacedNumberString = toArray.joinWithSeparator("")
        }
        
        
        if replacedNumberString.characters.count > maxNumberLength{
            return false
        }
        
        let textFieldNumber = Double(replacedNumberString)
        if let textFieldNumber = textFieldNumber{
            let textFieldNewValue = textFieldNumber/100
            let textFieldStringValue = currencyFormattor.stringFromNumber(textFieldNewValue)
            textField.text = textFieldStringValue
        }
   
        if let textFieldLength = textFieldLength{
            if(textFieldLength > cursorPosition){
                let difference = textFieldLength - cursorPosition
                let newLength = textField.text?.characters.count
                if let newLength = newLength{
                    let newOffset = newLength - difference
                    let newCursorPosition = textField.positionFromPosition(startPosition, offset: newOffset)
                    if let newCursorPosition = newCursorPosition{
                        let newSelectedRange = textField.textRangeFromPosition(newCursorPosition, toPosition: newCursorPosition)
                        textField.selectedTextRange = newSelectedRange
                    }
                }
                
            }
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
