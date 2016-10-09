//
//  GESortView.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/9/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GESortView: UIView {

    class func instanceFromNib() -> GESortView {
        return UINib(nibName: "GESortView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! GESortView
    }
}
