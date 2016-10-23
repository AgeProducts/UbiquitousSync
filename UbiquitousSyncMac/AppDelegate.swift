//
//  AppDelegate.swift
//  UbiquitousSyncDemo
//
//  Created by T.Hori on 2016/10/08.
//  Copyright © 2016年 Age Pro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        print("applicationDidFinishLaunching");
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
        print("applicationWillTerminate");
    }
}

