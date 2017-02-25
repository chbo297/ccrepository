//
//  File.swift
//  TEInit
//
//  Created by bo on 13/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import Foundation

class Father {
    let fa1 : Int
    var faStr : String?
    
    
    init(fa1 f1 : Int) {
        fa1 = f1
    }
    
    required init() {
        fa1 = 0
    }
    
     convenience init(_ con : String) {
        self.init()
        faStr = con
    }
    
     convenience init(conv2 con2 : String) {
        self.init()
        faStr = con2
    }
    
    
    func display() {
        print("int:\(fa1)\nstr:\(faStr)")
    }
    
}


class Son: Father {
    
    convenience init(son : Int) {
        self.init()
        faStr = "son"
    }
    
//    override init(fa1 f1 : Int) {
//        super.init(fa1: f1)
//        
//    }
    
//    required init(_ f1 : Int) {
//        super.init(f1)
//        
//    }
    
}
