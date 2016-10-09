//
//  GEBottomBarView.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

enum BottomBarButtonTap {
    case SortButton
}

class GEBottomBarView: UIView {
    
    var sortButtonClickCompletion:((tap:BottomBarButtonTap)->Void)?

    class func instanceFromNib() -> GEBottomBarView {
        return UINib(nibName: "GEBottomBarView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! GEBottomBarView
    }
    
    @IBAction func sortButtonClicked(sender: UIButton) {
        sortButtonClickCompletion!(tap: .SortButton)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
