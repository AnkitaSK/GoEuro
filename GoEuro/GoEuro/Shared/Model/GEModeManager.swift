//
//  GEModeManager.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GEModeManager: NSObject {
    static let sharedManager = GEModeManager()
    
    var modeDetails = [GEModeDetailModel]()
    
    func getBusTransportModeDetails(completiom:(success:Bool)->Void) ->Void {
        GoEuroApi.sharedAPI().getBusDataWithCompletion { [weak self](response, statusCode, error) -> Void in
            if let weakSelf = self {
                if error == nil && statusCode == 200 {
                    if let responseArray = response as? [[String : AnyObject]] {
                        
                        for object in responseArray {
                            let modeDetailModel = GEModeDetailModel(attributes: object)
                            weakSelf.modeDetails.append(modeDetailModel)
                        }
                    }
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
                            let modeDetailModel = GEModeDetailModel(attributes: object)
                            weakSelf.modeDetails.append(modeDetailModel)
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
                            let modeDetailModel = GEModeDetailModel(attributes: object)
                            weakSelf.modeDetails.append(modeDetailModel)
                        }
                    }
                }
            }
        }
    }
}
