//
//  GEBottomBarView.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

enum BottomBarButtons {
    case SortButton
    case OfferButton
}

class GEBottomBarView: UIView {
    
    var sortButtonClickCompletion:((tap:BottomBarButtons)->Void)?

    class func instanceFromNib() -> GEBottomBarView {
        return UINib(nibName: "GEBottomBarView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! GEBottomBarView
    }
    
    @IBAction func sortButtonClicked(sender: UIButton) {
        sortButtonClickCompletion!(tap: .SortButton)
    }
    
    
    @IBAction func offerButtonClicked(sender: UIButton) {
        sortButtonClickCompletion!(tap: .OfferButton)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
