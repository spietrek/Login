//
//  PasscodeViewController.swift
//  Login
//
//  Created by Stephen Pietrek on 11/12/15.
//  Copyright © 2015 Stephen Pietrek. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController {

    @IBOutlet weak var banner: BannerView!
    @IBOutlet weak var bannerConstraintHeight: NSLayoutConstraint!
    
    @IBAction func collapse(sender: UIButton) {
        UIView.animateWithDuration(0.2, animations: {
            self.banner.collapse()
            self.bannerConstraintHeight.constant = 50
            }
        )
    }
    
    @IBAction func expand(sender: UIButton) {
        UIView.animateWithDuration(0.2, animations: {
            self.bannerConstraintHeight.constant = 195
            self.banner.expand()
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
