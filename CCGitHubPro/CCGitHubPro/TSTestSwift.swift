//
//  TSTestSwift.swift
//  CCGitHubPro
//
//  Created by bo on 19/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import Foundation

protocol SomeProtocol {
    init(prar : Int)
    init(p1 : Int, p2 : Int)
}

class TopClass : SomeProtocol {
    var name = "topclass"
    
    required init(prar : Int) {
        self.name = "top init completion"
    }
    
    required init(p1 : Int, p2: Int) {
        
    }
    
    func furtherDo() {
        
    }
    
}

//class TSSubClass: TopClass {
//    required init(par: Int) {
//        super.init(par: par)
//        self.name = "sub init completion"
//    }
//    
//    required init(p1: Int, p2: Int) {
//        super.init(p1: p1, p2: p2)
//    }
//}
