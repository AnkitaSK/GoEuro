//
//  GETransportDetailListViewController.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/6/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

@objc class GETransportDetailListViewController: UITableViewController {
    
    override func viewDidLoad() {
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let customCell:GETransportModeCell = tableView.dequeueReusableCellWithIdentifier("TransportModeCell") as! GETransportModeCell
        
        
        return customCell
    }
}
