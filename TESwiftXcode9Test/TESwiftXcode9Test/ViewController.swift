//
//  ViewController.swift
//  TESwiftXcode9Test
//
//  Created by bo on 06/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let numberDictionary = ["one": 1, "two": 2, "three": 3, "four": 4]
        let evenOnly = numberDictionary.lazy.filter { (_, value) in
            value % 2 == 0
        }
        
        var viaIteration: [String: Int] = [:]
        for (key, value) in evenOnly {
            viaIteration[key] = value
        }
        
        let viaReduce: [String: Int] = evenOnly.reduce([:]) { (cumulative, kv) in
            var dict = cumulative
            dict[kv.key] = kv.value
            return dict
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

