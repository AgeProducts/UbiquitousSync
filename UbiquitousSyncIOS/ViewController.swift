//
//  ViewController.swift
//  UbiquitousSyncDemo
//
//  Created by T.Hori on 2016/07/28.
//  Copyright © 2016年 Age Pro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let maxValue = 10

class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var disposeBag:DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // UbiquitousSync.removeiCloudItems4Debug(iCloud_Prefix, cloud: true, local: true)      // DEBUG
        UbiquitousSync.startWithPrefix(iCloud_Prefix, restore:true)
       
        Common.sharedInstance.numberValue.asObservable().map{ return "\($0)"}
            .bindTo(numLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        plusButton.rx.tap.subscribe(onNext: {
            Common.sharedInstance.numberValue.value += 1
            if Common.sharedInstance.numberValue.value > maxValue {
                Common.sharedInstance.numberValue.value = maxValue
            }
        }).addDisposableTo(disposeBag)
        
        minusButton.rx.tap.subscribe(onNext: {
            Common.sharedInstance.numberValue.value -= 1
            if Common.sharedInstance.numberValue.value < -maxValue {
                Common.sharedInstance.numberValue.value = -maxValue
            }
        }).addDisposableTo(disposeBag)
        
        resetButton.rx.tap.subscribe(onNext: {
            Common.sharedInstance.numberValue.value = 0
        }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

