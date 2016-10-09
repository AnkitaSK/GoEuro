//
//  GESortView.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/9/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

enum SortByType {
    case Duration
    case ArrivalTime
}

class GESortView: UIView {
    
    var sortByButtonClickCompletion:((tap:SortByType)->Void)?

    class func instanceFromNib() -> GESortView {
        return UINib(nibName: "GESortView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! GESortView
    }
    
    @IBAction func sortByDurationButtonClicked(sender: UIButton) {
        sortByButtonClickCompletion!(tap: .Duration)
    }
    
    @IBAction func sortByArrivalTimeButtonClicked(sender: UIButton) {
        sortByButtonClickCompletion!(tap: .ArrivalTime)
    }
}
