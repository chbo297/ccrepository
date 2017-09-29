//
//  TEObj1.swift
//  TEObserveAndNotificaRelease
//
//  Created by bo on 03/07/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class TEObj1: NSObject {
    
    var name = "hahah"
    
    deinit {
        print("1 release")
    }

}
