//
//  GECacheManager.swift
//  GoEuro
//
//  Created by Ankita Kalangutkar on 10/8/16.
//  Copyright © 2016 Ankita Kalangutkar. All rights reserved.
//

import UIKit

class GECacheManager: NSObject {

//    create a shared manager
    static let sharedManager:GECacheManager = GECacheManager()
//    find or create the document dir using a getter
    private var documentDirectoryURL:NSURL {
        get {
            var pathURL:NSURL = NSURL()
            if let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first {
                if var documentDirectoryURL = NSURL(string: documentDirectoryPath) {
                    documentDirectoryURL = documentDirectoryURL.URLByAppendingPathComponent("GECache")
                    pathURL = documentDirectoryURL
                    if !NSFileManager.defaultManager().fileExistsAtPath(documentDirectoryURL.absoluteString) {
                        do {
                            try NSFileManager.defaultManager().createDirectoryAtPath(documentDirectoryURL.absoluteString, withIntermediateDirectories: true, attributes: nil)
                        }catch {
                            
                        }
                    }
                }
            }
            return pathURL
        }
    }
    
    private func getURL(key:String) -> String {
        return documentDirectoryURL.URLByAppendingPathComponent(key).URLByAppendingPathExtension("txt").absoluteString
    }

    func save(object:AnyObject, key:String) {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) { [weak self] in
            if let weakSelf = self {
                let cacheModel = GECacheModel(key: key, data: object)
                let archivedData:NSData = NSKeyedArchiver.archivedDataWithRootObject(cacheModel)
                do {
                    if !NSFileManager.defaultManager().fileExistsAtPath(weakSelf.getURL(key)) {
                        if NSFileManager.defaultManager().createFileAtPath(weakSelf.getURL(key), contents: nil, attributes: [NSFileType:NSFileTypeRegular]) {
                            
                            try archivedData.writeToFile(weakSelf.getURL(key
                                ), options: NSDataWritingOptions.AtomicWrite)
                            
                        }
                        else {
                            print("Failed to create the cache file")
                        }
                    }
                    else {
                        try archivedData.writeToFile(weakSelf.getURL(key), options: NSDataWritingOptions.AtomicWrite)
                    }
                }catch let (fileWriteError){
                    print("File write error: \(fileWriteError)")
                }
            }
            
        }
        
        
    }
    
    func object(forKey key:String) -> AnyObject? {
        if NSFileManager.defaultManager().fileExistsAtPath(getURL(key)) {
            do {
                let cachedData = try NSData(contentsOfFile: getURL(key), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                if let cachedObject = NSKeyedUnarchiver.unarchiveObjectWithData(cachedData) as? GECacheModel {
                    return cachedObject.cachedData
                }
                return nil
            }catch let fileWriteError {
                print("FEtching objects faliled:\(fileWriteError)")
            }
        }
        return nil
    }
    
}

private class GECacheModel:NSObject {
    var key:String?
    var cachedData:AnyObject?
    
    override init() {
        super.init()
    }
    
    convenience init(key:String, data:AnyObject) {
        self.init()
        self.key = key
        self.cachedData = data
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        key = aDecoder.decodeObjectForKey("cacheKey") as? String ?? ""
        cachedData = aDecoder.decodeObjectForKey("cacheData")
    }
}

extension GECacheModel:NSCoding {
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(key, forKey: "cacheKey")
        aCoder.encodeObject(cachedData, forKey: "cacheData")
    }
}
