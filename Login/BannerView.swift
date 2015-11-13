//
//  BannerView.swift
//  Login
//
//  Created by Stephen Pietrek on 11/12/15.
//  Copyright © 2015 Stephen Pietrek. All rights reserved.
//

import UIKit

@IBDesignable class BannerView: UIView {
    
    @IBOutlet weak var applicationTitle: UILabel!
    @IBOutlet weak var appImageView: UIView!
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var dividerConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var appImageViewConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var appTitleConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var appImageViewConstraintHeight: NSLayoutConstraint!
    
    // Our custom view from the XIB file
    var view: UIView!
    
    @IBInspectable var title: String? {
        get { return applicationTitle?.text }
        set { applicationTitle.text = newValue }
    }
    
    @IBInspectable var image: UIImage? {
        get {
            return appImage.image
        }
        set(image) {
            appImage.image = image
        }
    }
    
    func collapse() {
        self.appImageViewConstraintTop.constant = 0
        self.appImageView.hidden = true;
        self.appTitleConstraintTop.constant = -62
        self.applicationTitle.font = self.applicationTitle.font.fontWithSize(21)
        self.dividerConstraintHeight.constant = 6
    }
    
    func expand() {
        self.dividerConstraintHeight.constant = 10
        self.appTitleConstraintTop.constant = 30
        self.applicationTitle.font = self.applicationTitle.font.fontWithSize(30)
        self.appImageView.hidden = false;
        self.appImageViewConstraintTop.constant = 24
    }
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "BannerView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }

}
