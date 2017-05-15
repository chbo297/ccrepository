//
//  ViewController.swift
//  TECIFliter
//
//  Created by bo on 25/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ar = CIFilter.filterNames(inCategory: kCICategoryCompositeOperation)
        print("\(ar)")
        let filter = CIFilter.init(name: "CIAdditionCompositing")
        print("\(filter?.attributes)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

