//
//  ViewController.swift
//  TSTestLayer
//
//  Created by bo on 23/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let layer = CALayer()
//        layer.drawsAsynchronously
//        Thread
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            DispatchQueue.main.async {
                self.view.backgroundColor = UIColor.blue
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class TEView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        <#code#>
    }
}

