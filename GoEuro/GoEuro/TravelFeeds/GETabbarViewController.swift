//
//  GETabbarViewController.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GETabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addingTopBar ()
        addingBottomBar ()
        
        GETransportManager.sharedManager.getBusTransportModeDetails { (success) -> Void in
            if success {
                
            }
        }
        
        GETransportManager.sharedManager.getTrainTransportModeDetails { (success) -> Void in
            if success {
                
            }
        }
        
        GETransportManager.sharedManager.getFlightTransportModeDetails { (success) -> Void in
            if success {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addingBottomBar () {
        var bottomBar:GEBottomBarView = GEBottomBarView ()
        bottomBar = GEBottomBarView.instanceFromNib()
        bottomBar.frame = CGRectMake(0, view.bounds.size.height - 48, view.bounds.size.width, 48)
        view.addSubview(bottomBar)
    }
    
    func addingTopBar () {
        var topTabBar:GETabbarView = GETabbarView ()
        topTabBar = GETabbarView.instanceFromNib()
        topTabBar.frame = CGRectMake(0, 64, view.bounds.size.width , 79)
        view.addSubview(topTabBar)
        
        topTabBar.buttonClickCompletion = {[weak self] ButtonTap in
            if let weakSelf = self {
                switch ButtonTap {
                case .BusButtonTap:
                    let parameters = ["transportDetails": GETransportManager.sharedManager.busTransportDetails]
                    NSNotificationCenter.defaultCenter().postNotificationName("ReloadListView", object:parameters)
                    break
                    
                case .TrainButtonTap:
                    let parameters = ["transportDetails": GETransportManager.sharedManager.trainTransportDetails]
                    NSNotificationCenter.defaultCenter().postNotificationName("ReloadListView", object:parameters)
                    break
                    
                case .FlightButtonTap:
                    let parameters = ["transportDetails": GETransportManager.sharedManager.flightTransportDetails]
                    NSNotificationCenter.defaultCenter().postNotificationName("ReloadListView", object:parameters)
                    break
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
