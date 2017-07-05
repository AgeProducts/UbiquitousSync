//
//  MenuController.swift
//  UbiquitousSyncDemo
//
//  Created by T.Hori on 2016/07/28.
//  Copyright © 2016年 Age Pro. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

let maxValue = 10

class MenuController:  NSObject {
    
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var plusMenuItem: NSMenuItem!
    @IBOutlet weak var restMenuItem: NSMenuItem!
    @IBOutlet weak var minusMenuItem: NSMenuItem!
    var statusItem = NSStatusItem()
  
    var disposeBag:DisposeBag = DisposeBag()
    
    override func awakeFromNib() {

        // Do any additional setup after loading the view, typically from a nib.

        // UbiquitousSync.removeiCloudItems4Debug(iCloud_Prefix, cloud: true, local: true)      // DEBUG
        UbiquitousSync.startWithPrefix(iCloud_Prefix, restore:true)
        
        let statusBar = NSStatusBar.system
        self.statusItem = statusBar.statusItem(withLength: CGFloat(60))
        self.statusItem.target = self;
        self.statusItem.action =  #selector(MenuController.showMenu)
        // showMenu()

//        Common.sharedInstance.numberValue.asObservable().subscribeNext { [weak self] _ in
//            guard let wself = self else { return }
//            wself.statusItem.title = "#" + String(Common.sharedInstance.numberValue.value)
//        }
//        .addDisposableTo(disposeBag)
        
        Common.sharedInstance.numberValue.asObservable().subscribe(onNext: { [weak self] _ in
            guard let wself = self else { return }
            wself.statusItem.title = "#" + String(Common.sharedInstance.numberValue.value)
            }).addDisposableTo(disposeBag)
    }
    
    @objc func showMenu() {
        self.statusItem.popUpMenu(menu)
    }

    @IBAction func plusAction(_ sender: AnyObject) {
        Common.sharedInstance.numberValue.value += 1
        if Common.sharedInstance.numberValue.value > maxValue {
            Common.sharedInstance.numberValue.value = maxValue
        }
    }

    @IBAction func minusAction(_ sender: AnyObject) {
        Common.sharedInstance.numberValue.value -= 1
        if Common.sharedInstance.numberValue.value < -maxValue {
            Common.sharedInstance.numberValue.value = -maxValue
        }
    }

    @IBAction func resetActiom(_ sender: AnyObject) {
        Common.sharedInstance.numberValue.value = 0
    }
    
    @IBAction func quitAction(_ sender: AnyObject) {
        NSApplication.shared.terminate(self)
    }
}

