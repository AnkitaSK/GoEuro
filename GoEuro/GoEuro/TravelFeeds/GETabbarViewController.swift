//
//  GETabbarViewController.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/5/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

@objc enum TransportType:Int {
    case Bus = 0
    case Train = 1
    case Flight = 2
}

class GETabbarViewController: UITabBarController {
    
    var sortView:GESortView?
    var overlayView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        addingTopBar ()
        addingBottomBar ()
        
        
        
//        3275
//        let testArray = twoSum([1,4,2,3], target: 1)
//        print(testArray)
        
//        test()
        
//        GETransportManager.sharedManager.getTrainTransportModeDetails { (success) -> Void in
//            if success {
//                
//            }
//        }
////
//        GETransportManager.sharedManager.getFlightTransportModeDetails { (success) -> Void in
//            if success {
//                
//            }
//        }
    }
    
    func twoSum(nums:[Int], target:Int) -> [Int] {
        var targetArray:[Int] = [Int]()
        var i:Int
        for i = 0;i<nums.count;i++ {
            var j:Int = 0
            for j = 0;j<=i;j++ {
                if i+1 < nums.count {
                    let temp = nums[i+1] + nums[j]
                    print(temp)
                    if temp == target {
                        targetArray.append(j)
                        targetArray.append(i+1)
                        
                        return targetArray
                    }
                }
                
            }
        }
        return targetArray
    }
    
    
    func test () {
//        var levelCount: Int = 0
//        let n = 3
//        var k:Int
//        for k = n; k>0; (k = k - 1) {
//            var l:Int = (k - 1)
//            for l = (k - 1); l>0; l-- {
//                print(" ",terminator:"")
//            }
////            print("*")
//            levelCount = levelCount + 1
//            
//            var z:Int = l
//            for z = 0; z < levelCount; z++ {
//                print("*",terminator:"")
//            }
//            print("\n")
//        }
        
        let n = 3
        var k:Int
        for k = n; k>0; (k = k - 1) {
//            print(k)
            var l:Int
            for l = 0; l<(k - 1);l++ {
                print(" ",terminator:"")
            }
            
            var z:Int
            
            for z = 2; z <= (2 * (n - l)); z++ {
                print("*",terminator:"")
            }
            print("\n")
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
        bottomBar.sortButtonClickCompletion = {[weak self] BottomBarButtons in
            if let weakSelf = self {
                switch (BottomBarButtons) {
                case .SortButton:
                    weakSelf.addingSortView()
                    break
                case .OfferButton:
                    let alertController = UIAlertController(title: "Alert", message: "Offer details are not yet implemented!", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    weakSelf.presentViewController(alertController, animated: true, completion: nil)
                    
                    break
                }
                
            }
        }
        view.addSubview(bottomBar)
    }
    
    func gestureRecogniser() {
        sortView?.removeFromSuperview()
        overlayView?.removeFromSuperview()
    }
    
    func addingSortView () {
        overlayView = UIView()
        overlayView!.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        overlayView!.backgroundColor = UIColor(red:0, green: 0, blue: 0, alpha: 0.6)
        view.addSubview(overlayView!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:Selector("gestureRecogniser"))
        overlayView!.addGestureRecognizer(tapGesture)
        
        
//         = GESortView()
        sortView = GESortView.instanceFromNib()
        sortView!.frame = CGRectMake(view.bounds.size.width/2 - sortView!.frame.size.width/2, view.bounds.size.height/2 + sortView!.frame.size.height/2 - 40, sortView!.frame.size.width, sortView!.frame.size.height)
        sortView!.sortByButtonClickCompletion = { SortByType in
            switch SortByType {
            case .Duration:
                let parameters = ["sortByKey":"duration"]
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadBySorting", object:parameters)
                break
            case .ArrivalTime:
                let parameters = ["sortByKey":"arrivalTime"]
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadBySorting", object:parameters)
                break
            }
        }
        view.addSubview(sortView!)
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
                    let parameters = ["transportDetails": GETransportManager.sharedManager.busTransportDetails,
                                        "transportType": NSNumber(integer: TransportType.Bus.rawValue)]
                    NSNotificationCenter.defaultCenter().postNotificationName("ReloadListView", object:parameters)
                    break
                    
                case .TrainButtonTap:
                    let parameters = ["transportDetails": GETransportManager.sharedManager.trainTransportDetails,
                        "transportType":NSNumber(integer: TransportType.Train.rawValue)]
                    NSNotificationCenter.defaultCenter().postNotificationName("ReloadListView", object:parameters)
                    break
                    
                case .FlightButtonTap:
                    let parameters = ["transportDetails": GETransportManager.sharedManager.flightTransportDetails,
                        "transportType":NSNumber(integer: TransportType.Flight.rawValue)]
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
