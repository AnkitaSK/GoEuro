//
//  Mode.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GEModeDetailModel: NSObject {
    var id:NSInteger?
    var providerLogo: String?
    var priceInEuros: NSInteger?
    var departureTime: String?
    var arrivalTime: String?
    var numberOfStops: NSInteger?
    
    init(attributes:[String : AnyObject]) {
        id = attributes["id"] as? NSInteger ?? 0
        providerLogo = attributes["provider_logo"] as? String ?? ""
        priceInEuros = attributes["price_in_euros"] as? NSInteger ?? 0
        departureTime = attributes["departure_time"] as? String ?? ""
        arrivalTime = attributes["arrival_time"] as? String ?? ""
        numberOfStops = attributes["number_of_stops"] as? NSInteger ?? 0
    }
}
