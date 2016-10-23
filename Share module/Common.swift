//
//  Common.swift
//  UbiquitousSyncDemo
//
//  Created by T.Hori on 2016/07/28.
//  Copyright © 2016年 Age Pro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Common : NSObject {
    
    var numberValue:Variable = Variable(0)
    var disposeBag:DisposeBag = DisposeBag()
    
    static let sharedInstance: Common = {
        let instance = Common ()
        return instance
    }()
    
    override init () {
        
        super.init()
        
        numberValue = Variable(getNumber())
        
        numberValue.asObservable().subscribe(onNext: { [unowned self] in
            NSLog (">>>>> \($0)")
            self.setNumber($0)
        }).addDisposableTo(disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: kUbiquitousSyncNotification), object: nil)
            .subscribe(onNext: { [unowned self] notification in
                if let userInfo = notification.userInfo,
                    let keys = userInfo[UbiquitousValueChangedKeysKey] as? [String] {
                    keys.forEach {
                        NSLog ("Key = \($0)")
                        self.numberValue.value = self.getNumber()
                    }
                }
            }).addDisposableTo(disposeBag)
    }
    
    deinit {
    }
    
    /* remote interface */
    let DEFAULT_Number = "0"
    let UD_Number_KEY = iCloud_Prefix + "Number_KEY"

    func getNumber() -> Int {
        if let value = UserDefaults.standard.object(forKey: UD_Number_KEY) as? String {
            return Int(value)!
        } else {
            UserDefaults.standard.set(DEFAULT_Number, forKey:UD_Number_KEY)
            UserDefaults.standard.synchronize()
            return Int(DEFAULT_Number)!
        }
    }
    func setNumber(_ value:Int) {
        let s = String(value)
        UserDefaults.standard.set(s, forKey:UD_Number_KEY)
        UserDefaults.standard.synchronize()
    }
    func resetNumber() {
        UserDefaults.standard.set(DEFAULT_Number, forKey:UD_Number_KEY)
        UserDefaults.standard.synchronize()
    }
}
