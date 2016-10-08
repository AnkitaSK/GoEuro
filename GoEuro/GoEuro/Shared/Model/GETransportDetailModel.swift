//
//  Mode.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GETransportDetailModel: NSObject {
    var id:NSInteger = 0
    var providerLogo: String?
    var priceInEuros: NSInteger = 0
    var departureTime: String?
    var arrivalTime: String?
    var numberOfStops: NSInteger = 0
    
    override init() {
        super.init()
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObjectForKey("id") as? NSInteger ?? 0
        providerLogo = aDecoder.decodeObjectForKey("provider_logo") as? String ?? ""
        priceInEuros = aDecoder.decodeObjectForKey("price_in_euros") as? NSInteger ?? 0
        departureTime = aDecoder.decodeObjectForKey("departure_time") as? String ?? ""
        arrivalTime = aDecoder.decodeObjectForKey("arrival_time") as? String ?? ""
        numberOfStops = aDecoder.decodeObjectForKey("number_of_stops") as? NSInteger ?? 0
    }
    
    convenience init(attributes:[String : AnyObject]) {
        self.init()
        id = attributes["id"] as? NSInteger ?? 0
        providerLogo = attributes["provider_logo"] as? String ?? ""
        priceInEuros = attributes["price_in_euros"] as? NSInteger ?? 0
        departureTime = attributes["departure_time"] as? String ?? ""
        arrivalTime = attributes["arrival_time"] as? String ?? ""
        numberOfStops = attributes["number_of_stops"] as? NSInteger ?? 0
    }
}

extension GETransportDetailModel:NSCoding {
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id,forKey: "id")
        aCoder.encodeObject(providerLogo, forKey: "provider_logo")
        aCoder.encodeObject(priceInEuros, forKey: "price_in_euros")
        aCoder.encodeObject(departureTime, forKey: "departure_time")
        aCoder.encodeObject(arrivalTime, forKey: "arrival_time")
        aCoder.encodeObject(numberOfStops, forKey: "number_of_stops")
    }
}
