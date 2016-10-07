//
//  GEModeManager.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GETransportManager: NSObject {
    static let sharedManager = GETransportManager()
    
    var busTransportDetails = [GETransportDetailModel]()
    var trainTransportDetails = [GETransportDetailModel]()
    var flightTransportDetails = [GETransportDetailModel]()
    
    func getBusTransportModeDetails(completiom:(success:Bool)->Void) {
        GoEuroApi.sharedAPI().getBusDataWithCompletion { [weak self](response, statusCode, error) -> Void in
            if let weakSelf = self {
                if error == nil && statusCode == 200 {
                    if let responseArray = response as? [[String : AnyObject]] {
                        
                        for object in responseArray {
                            let modeDetailModel = GETransportDetailModel(attributes: object)
                            weakSelf.busTransportDetails.append(modeDetailModel)
                        }
                    }
                    
                    completiom(success: true)
                }
            }
        }
    }
    
    func getTrainTransportModeDetails(completiom:(success:Bool)->Void) ->Void {
        GoEuroApi.sharedAPI().getTrainDataWithCompletion { [weak self](response, statusCode, error) -> Void in
            if let weakSelf = self {
                if error == nil && statusCode == 200 {
                    if let responseArray = response as? [[String : AnyObject]] {
                        
                        for object in responseArray {
                            let modeDetailModel = GETransportDetailModel(attributes: object)
                            weakSelf.trainTransportDetails.append(modeDetailModel)
                        }
                    }
                }
            }
        }
    }
    
    func getFlightTransportModeDetails(completiom:(success:Bool)->Void) ->Void {
        
        GoEuroApi.sharedAPI().getFlightDataWithCompletion { [weak self](response, statusCode, error) -> Void in
            if let weakSelf = self {
                if error == nil && statusCode == 200 {
                    if let responseArray = response as? [[String : AnyObject]] {
                        
                        for object in responseArray {
                            let modeDetailModel = GETransportDetailModel(attributes: object)
                            weakSelf.flightTransportDetails.append(modeDetailModel)
                        }
                    }
                }
            }
        }
    }
}
