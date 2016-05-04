//
//  ColorChangingTextFieldDelegate.swift
//  FunkyTextFields
//
//  Created by Deshmukh,Richa on 4/29/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import Foundation
import UIKit

class ColorChangingTextFieldDelegate : NSObject, UITextFieldDelegate{
    
    let colors : [UIColor] = [UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.blueColor(),
        UIColor.brownColor(),
        UIColor.blackColor(),
        UIColor.purpleColor(),
        UIColor.cyanColor(),
        UIColor.magentaColor(),
        UIColor.whiteColor()
    ]
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let randomNum = Int(arc4random_uniform(UInt32(colors.count)))
        let randomColor = colors[randomNum]
        
        textField.backgroundColor = randomColor
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}