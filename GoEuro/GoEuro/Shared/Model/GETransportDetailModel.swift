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
    var duration: String?
    
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
        duration = aDecoder.decodeObjectForKey("duration") as? String ?? ""
    }
    
    convenience init(attributes:[String : AnyObject]) {
        self.init()
        id = attributes["id"] as? NSInteger ?? 0
        providerLogo = attributes["provider_logo"] as? String ?? ""
        priceInEuros = attributes["price_in_euros"] as? NSInteger ?? 0
        departureTime = attributes["departure_time"] as? String ?? ""
        arrivalTime = attributes["arrival_time"] as? String ?? ""
        numberOfStops = attributes["number_of_stops"] as? NSInteger ?? 0
        
        timeDuration()
    }
    
    func parseDuration(timeString:String) -> NSTimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        
        var interval:Double = 0
        
        let parts = timeString.componentsSeparatedByString(":")
        for (index, part) in parts.reverse().enumerate() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        
        return interval
    }

    
    func timeDuration() {
        let arrivalDateTime:NSDate = NSDate(timeIntervalSince1970:parseDuration(arrivalTime!))
        let departureDateTime:NSDate = NSDate(timeIntervalSince1970: parseDuration(departureTime!))
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour,.Minute,.Second], fromDate: departureDateTime, toDate: arrivalDateTime, options: [])
        
        print(components.hour,components.minute,components.second)
        duration = String(components.minute) + ":" + String(components.second)
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
        aCoder.encodeObject(duration, forKey: "duration")
    }
}
