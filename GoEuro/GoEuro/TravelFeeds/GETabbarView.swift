//
//  GETabbar.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

enum ButtonTap {
    case TrainButtonTap
    case BusButtonTap
    case FlightButtonTap
}

class GETabbarView: UIView {
    
    var buttonClickCompletion : ((tap : ButtonTap)->Void)?
    
    class func instanceFromNib() -> GETabbarView {
        return UINib(nibName: "GETabbarView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! GETabbarView
    }
    
    
    @IBAction func trainButtonClicked(sender: UIButton) {
        buttonClickCompletion!(tap: .TrainButtonTap)
        
        
    }
    
    @IBAction func busButtonClicked(sender: UIButton) {
        buttonClickCompletion!(tap: .BusButtonTap)
    }
    
    @IBAction func flightButtonClicked(sender: UIButton) {
        buttonClickCompletion!(tap: .FlightButtonTap)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
