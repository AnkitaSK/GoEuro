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
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var busButton: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var flightButton: UIButton!
    
    @IBAction func trainButtonClicked(sender: UIButton) {
        buttonClickCompletion!(tap: .TrainButtonTap)
        lineView.frame = CGRectMake(trainButton.frame.origin.x, lineView.frame.origin.y, lineView.frame.size.width, lineView.frame.size.height)
    }
    
    @IBAction func busButtonClicked(sender: UIButton) {
        buttonClickCompletion!(tap: .BusButtonTap)
        lineView.frame = CGRectMake(busButton.frame.origin.x, lineView.frame.origin.y, lineView.frame.size.width, lineView.frame.size.height)
    }
    
    @IBAction func flightButtonClicked(sender: UIButton) {
        buttonClickCompletion!(tap: .FlightButtonTap)
        lineView.frame = CGRectMake(flightButton.frame.origin.x, lineView.frame.origin.y, lineView.frame.size.width, lineView.frame.size.height)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
