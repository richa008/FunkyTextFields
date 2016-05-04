//
//  ZipCodeTextFieldDelegate.swift
//  FunkyTextFields
//
//  Created by Deshmukh,Richa on 5/2/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import Foundation
import UIKit

class ZipCodeTextFieldDelegate: NSObject, UITextFieldDelegate{

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(textField.text?.characters.count >= 5){
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}