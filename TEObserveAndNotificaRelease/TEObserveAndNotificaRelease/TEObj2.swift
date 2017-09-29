//
//  TEObj2.swift
//  TEObserveAndNotificaRelease
//
//  Created by bo on 03/07/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class TEObj2: NSObject {

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "name" {
            print("\(String(describing: change))")
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func notificationReceive(notification : NSNotification) {
        print("\(notification)")
    }
    
    deinit {
        print("2 release")
    }
    
}
