//
//  CreatePasscodeViewController.swift
//  Login
//
//  Created by Stephen Pietrek on 11/11/15.
//  Copyright © 2015 Stephen Pietrek. All rights reserved.
//

import UIKit

class CreatePasscodeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passcode1TextField: UITextField!
    @IBOutlet weak var passcode2TextField: UITextField!
    @IBOutlet weak var banner: BannerView!
    @IBOutlet weak var bannerConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitViewConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var passcodesNotMatchLabel: UILabel!
    
    @IBAction func submit(sender: UIButton) {
        self.performSegueWithIdentifier("PasscodeSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        submitView.hidden = true
        passcodesNotMatchLabel.hidden = true
        passcode2TextField.hidden = true
        let borderColor : UIColor = UIColor( red: 0, green: 0.639, blue: 0.878, alpha: 1.0 )
        passcode1TextField.layer.borderWidth = 1
        passcode1TextField.layer.borderColor = borderColor.CGColor
        passcode2TextField.layer.borderWidth = 1
        passcode2TextField.layer.borderColor = borderColor.CGColor
        banner.title = "ASV"
        
        passcode1TextField.delegate = self
        passcode1TextField.addTarget(self, action: "passcodeDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        passcode2TextField.delegate = self
        passcode2TextField.addTarget(self, action: "passcodeDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }

    override func viewDidAppear(animated: Bool) {
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.deregisterFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerForKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHidden:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications () -> Void {
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(aNotification: NSNotification) {
        let info = aNotification.userInfo!
        let kbSize = (info[UIKeyboardFrameBeginUserInfoKey])!.CGRectValue.size
        
        UIView.animateWithDuration(0.2, animations: {
            self.banner.collapse()
            self.bannerConstraintHeight.constant = 50
            self.submitViewConstraintBottom.constant = kbSize.height
            }
        )
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        UIView.animateWithDuration(0.2, animations: {
            self.bannerConstraintHeight.constant = 195
            self.banner.expand()
            }
        )
    }
    
    func passcodeDidChange(textField: UITextField) {
        self.submitView.hidden = true

        if passcode1TextField.text == passcode2TextField.text {
            self.submitView.hidden = false
            self.passcodesNotMatchLabel.hidden = true
        } else if passcode1TextField.text == "" {
            passcode2TextField.hidden = true
            passcode2TextField.text = ""
        } else if passcode1TextField.text!.characters.count == 4 {
            self.passcodesNotMatchLabel.hidden = false
            passcode2TextField.hidden = false
        }
    }
}

private var maxLengthDictionary = [UITextField:Int]()

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = maxLengthDictionary[self] {
                return length
            } else {
                return Int.max
            }
        }
        set {
            maxLengthDictionary[self] = newValue
            addTarget(self, action: "checkMaxLength:", forControlEvents: UIControlEvents.EditingChanged)
        }
    }
    
    func checkMaxLength(sender: UITextField) {
        let newText = sender.text
        if newText!.characters.count > maxLength {
            let cursorPosition = selectedTextRange
            text = (newText! as NSString).substringWithRange(NSRange(location: 0, length: maxLength))
            selectedTextRange = cursorPosition
        }
    }
}
