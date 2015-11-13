//
//  LoginViewController.swift
//  Login
//
//  Created by Stephen Pietrek on 11/11/15.
//  Copyright © 2015 Stephen Pietrek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var qidTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var banner: BannerView!
    @IBOutlet weak var bannerConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitViewConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var legalPrivacyButton: UIButton!
    
    @IBAction func submitUserIdPassword(sender: UIButton) {
        if (qidTextField.text != "" && passwordTextField! != "") {
            self.performSegueWithIdentifier("PasscodeCreateSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitView.hidden = true
        let borderColor : UIColor = UIColor( red: 0, green: 0.639, blue: 0.878, alpha: 1.0 )
        self.qidTextField.layer.borderWidth = 1
        self.qidTextField.layer.borderColor = borderColor.CGColor
        self.passwordTextField.layer.borderWidth = 1
        self.passwordTextField.layer.borderColor = borderColor.CGColor
        self.banner.title = "ASV"
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        self.registerForKeyboardNotification()
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
            if (self.bannerConstraintHeight.constant == 195) {
                self.bannerConstraintHeight.constant = 195
                self.submitView.alpha = 0
                self.submitView.hidden = false
                self.submitViewConstraintBottom.constant = kbSize.height
            }
            }, completion: {
                (value: Bool) in
                self.bannerConstraintHeight.constant = 50
                self.submitView.alpha = 1
                self.banner.collapse()
            }
        )
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        UIView.animateWithDuration(0.2, animations: {
            self.bannerConstraintHeight.constant = 50
            self.submitView.hidden = true
            }, completion: {
                (value: Bool) in
                self.bannerConstraintHeight.constant = 195
                self.banner.expand()
            }
        )
    }
}
