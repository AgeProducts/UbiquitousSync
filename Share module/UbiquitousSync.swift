//
//  UbiquitousSync.swift
//
//  Created by T.Hori on 2016/09/07.
//  Copyright © 2016年 Age Pro. All rights reserved.
//

import Foundation

let kUbiquitousSyncNotification = "iCloudDidUpdateToLatest"
let UbiquitousValueChangedKeysKey    = "UbiquitousValueChangedKeysKey"

var prefix = ""
let iCloud_Prefix = "iCloud_"

class UbiquitousSync {

    @objc fileprivate static func updateToiCloud(_ notificationObject:Notification)  {
        
        NSLog("updateToiCloud:notificationObject -->> To iClod")
        
        let iCloudStore = NSUbiquitousKeyValueStore.default
        let localStore = UserDefaults.standard
        let dict = localStore.dictionaryRepresentation()
        var changeKeys:[String] = []
        
        dict.forEach {
            if $0.0.hasPrefix(prefix) {
                if let OBJ = iCloudStore.object(forKey: $0.0) {
                    if ($0.1 as AnyObject).isEqual(OBJ) == false {
                        NSLog("updateToiCloud: find update item To iClod -->> key:\($0.0)")
                        changeKeys.append($0.0)
                        iCloudStore.set($0.1, forKey: $0.0)
                    }/* else {
                        NSLog("updateToiCloud: find same item, no update iCloud -->> key:\($0.0)")
                    } */
                } else {
                    NSLog("updateToiCloud: create new item To iClod -->> key:\($0.0)")
                    changeKeys.append($0.0)
                    iCloudStore.set($0.1, forKey: $0.0)
                }
            }
        }
        if changeKeys.isEmpty == false {
            if iCloudStore.synchronize() == false {
                NSLog("updateToiCloud: iCloud synchronize error")
            }
            // assert(iCloudStore.synchronize(), "UpdateToiCloud: iCloud synchronize error")
        }
    }
    
    @objc fileprivate static func updateFromiCloud(_ notificationObject:Notification)  {
        
        NSLog("updateFromiCloud:notificationObject -->> To macOS/iOS")
        
        let iCloudStore = NSUbiquitousKeyValueStore.default
        let localStore = UserDefaults.standard
        let dict = iCloudStore.dictionaryRepresentation
        var changeKeys:[String] = []
        
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
        
        dict.forEach {
            if $0.0.hasPrefix(prefix) {
                if let OBJ = localStore.object(forKey: $0.0) {
                    if ($0.1 as AnyObject).isEqual(OBJ) == false {
                        NSLog("updateFromiCloud: find update local item -->> key:\($0.0)")
                        changeKeys.append($0.0)
                        localStore.set($0.1, forKey: $0.0)
                    } /* else {
                        NSLog("updateFromiCloud: find same item, no update local item -->> key:\($0.0)")
                    } */
                } else {
                    NSLog("updateFromiCloud: create new local item -->> key:\($0.0)")
                    changeKeys.append($0.0)
                    localStore.set($0.1, forKey: $0.0)
                }
            }
        }
        if changeKeys.isEmpty == false {
            assert(localStore.synchronize(), "updateFromiCloud: local synchronize error")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(UbiquitousSync.updateToiCloud(_:)), name: UserDefaults.didChangeNotification, object: nil)
        
        if changeKeys.isEmpty == false {
            NSLog("updateFromiCloud: changed keys \(changeKeys)")
            let dic = [UbiquitousValueChangedKeysKey : changeKeys as AnyObject]
            NotificationCenter.default.post(name: Notification.Name(rawValue: kUbiquitousSyncNotification), object: self, userInfo: dic)
        }
    }
    
    static func startWithPrefix(_ prefixToSync:String = iCloud_Prefix, restore:Bool = true) {
        
        NSLog("startWithPrefix. prefix:\(prefixToSync) restore:\(restore)")

        prefix = prefixToSync

        if restore == true {
            
            let iCloudStore = NSUbiquitousKeyValueStore.default
            let localStore = UserDefaults.standard
            let dict = iCloudStore.dictionaryRepresentation
            var changeKeys:[String] = []

            dict.forEach {
                if $0.0.hasPrefix(prefixToSync) {
                    NSLog("startWithPrefix: iCloud object \($0.0), \($0.1)")
                    if let OBJ = localStore.object(forKey: $0.0) {
                        if ($0.1 as AnyObject).isEqual(OBJ) == false {
                            NSLog("startWithPrefix: find update item from iClod -->> key:\($0.0)")
                            changeKeys.append($0.0)
                            localStore.set($0.1, forKey: $0.0)
                        }
                    } else {
                        NSLog("startWithPrefix:  create new item from iClod -->> key:\($0.0)")
                        changeKeys.append($0.0)
                        localStore.set($0.1, forKey: $0.0)
                    }
                }
            }
            if changeKeys.isEmpty == false {
                assert(localStore.synchronize(), "startWithPrefix: local synchronize error")
            }
        }

        NotificationCenter.default.addObserver(self, selector: #selector(UbiquitousSync.updateFromiCloud(_:)), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UbiquitousSync.updateToiCloud(_:)), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    static func removeiCloudItems4Debug(_ prefix:String = iCloud_Prefix, cloud:Bool, local:Bool) {
        if cloud == true {
            let iCloudStore = NSUbiquitousKeyValueStore.default
            let dict = iCloudStore.dictionaryRepresentation
            dict.keys.forEach {
                if $0.hasPrefix(prefix) {
                    NSLog("removeiCloudItems4Debug: remove iCloudStore item \($0). for DEBUG!!")
                    iCloudStore.removeObject(forKey: $0)
                }
            }
            if iCloudStore.synchronize() == false {
                NSLog("removeiCloudItems4Debug: iCloud synchronize error")
            }
            // assert(iCloudStore.synchronize(), "removeiCloudItems4Debug: iCloud synchronize error")
        }
        if local == true {
            let localStore = UserDefaults.standard
            let dict = localStore.dictionaryRepresentation()
            dict.keys.forEach {
                if $0.hasPrefix(prefix) {
                    NSLog("removeiCloudItems4Debug: remove localStore item \($0). for DEBUG!!")
                    localStore.removeObject(forKey: $0)
                }
            }
            assert(localStore.synchronize(), "removeiCloudItems4Debug: local synchronize error")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
}
