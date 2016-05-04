//
//  EmojiTextFieldDelegate.swift
//  FunkyTextFields
//
//  Created by Deshmukh,Richa on 4/29/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import Foundation
import UIKit

class EmojiTextFieldDelegate: NSObject, UITextFieldDelegate{
    
    let translations : [String: String] =  [
        "heart" : "\u{0001F496}",
        "fish" : "\u{E522}",
        "bird" : "\u{E523}",
        "frog" : "\u{E531}",
        "bear" : "\u{E527}",
        "dog" : "\u{E052}",
        "cat" : "\u{E04F}"
    ]
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var emojiStringRange: NSRange, newText : NSString = "", stringReplaced: Bool = false
        if let text = textField.text{
             newText = text as NSString
        }
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        for (emojiString, emoji) in translations{
            repeat{
                emojiStringRange = newText.rangeOfString(emojiString, options: NSStringCompareOptions.CaseInsensitiveSearch)
                if(emojiStringRange.location != NSNotFound){
                    newText = newText.stringByReplacingOccurrencesOfString(emojiString, withString: emoji)
                    stringReplaced = true
                }
            
            }while emojiStringRange.location != NSNotFound
        }
        if(stringReplaced){
            textField.text = newText as String
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}