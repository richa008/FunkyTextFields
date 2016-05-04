//
//  ViewController.swift
//  FunkyTextFields
//
//  Created by Deshmukh,Richa on 4/29/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var colorDetectingTextField: UITextField!
    @IBOutlet weak var colorChangingTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var lockableTextField: UITextField!
    @IBOutlet weak var characterCountTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lockableSwitch: UISwitch!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    let emojiTextFieldDelegate = EmojiTextFieldDelegate()
    let colorDetectingTextFieldDelegate = ColorizerTextFieldDelegate()
    let colorChangingTextFieldDelegate = ColorChangingTextFieldDelegate()
    let zipCodeTextFieldDelegate = ZipCodeTextFieldDelegate()
    let currencyTextFieldDelegate = CurrencyTextFieldDelegate()
    
    var keyBoardShowing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiTextField.delegate = emojiTextFieldDelegate
        colorDetectingTextField.delegate = colorDetectingTextFieldDelegate
        colorChangingTextField.delegate = colorChangingTextFieldDelegate
        zipCodeTextField.delegate = zipCodeTextFieldDelegate
        currencyTextField.delegate = currencyTextFieldDelegate
        lockableTextField.delegate = self
        characterCountTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        registerForKeyboardNotifications()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Mark: Keyboard functions
    
    func keyboardWasShown(notification: NSNotification) {
        if(!keyBoardShowing){
            var userInfo = notification.userInfo!
            var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
            keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
            
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            self.scrollView.contentInset = contentInset
            keyBoardShowing = true
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInset

        keyBoardShowing = false
    }
    
    // Mark: UI Text field delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //Lockable text field
        if(textField.tag == 5){
            if(!self.lockableSwitch.on){
                return false
            }
        //Character count text field
        }else if(textField.tag == 6){
            let text = textField.text! + string;
            var count = text.characters.count
            if(string == ""){
               count--
            }
            characterCountLabel.text = String(count)
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

