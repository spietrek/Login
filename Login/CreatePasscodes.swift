//
//  Passcodes.swift
//  Login
//
//  Created by Stephen Pietrek on 11/13/15.
//  Copyright © 2015 Stephen Pietrek. All rights reserved.
//

import UIKit

class CreatePasscodes: NSObject, UITextFieldDelegate {
    
    var passcode1TextField: UITextField!
    var passcode2TextField: UITextField!
    var messageLabel: UILabel!
    
    init(vc: CreatePasscodeViewController, textField1: UITextField, textField2: UITextField, messageLabel: UILabel) {
        super.init()
        self.passcode1TextField = textField1
        self.passcode2TextField = textField2
        self.messageLabel = messageLabel
        
        self.passcode1TextField.delegate = vc
        self.passcode1TextField.addTarget(vc, action: "passcodeDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.passcode2TextField.delegate = vc
        self.passcode2TextField.addTarget(vc, action: "passcodeDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func passcodeDidChange(textField: UITextField) {
        print("passcode changes")
    }
}

