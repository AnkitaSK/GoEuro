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

        addingCustomTabBar ()
        addingBottomBar ()
        
        GETransportManager.sharedManager.getBusTransportModeDetails { (success) -> Void in
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
    
    func addingCustomTabBar () {
        var topTabBar:GETabbarView = GETabbarView ()
        topTabBar = GETabbarView.instanceFromNib()
        topTabBar.frame = CGRectMake(0, 64, view.bounds.size.width , 79)
        view.addSubview(topTabBar)
        
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
