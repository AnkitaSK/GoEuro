//
//  GETabbar.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GETabbarView: UIView {
    
    class func instanceFromNib() -> GETabbarView {
        return UINib(nibName: "GETabbarView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! GETabbarView
    }
    
    
    @IBAction func trainButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func busButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func flightButtonClicked(sender: UIButton) {
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
