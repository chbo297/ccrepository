//
//  ViewController.swift
//  TEDraw
//
//  Created by bo on 10/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ted = TEDrawtes()
        ted.backgroundColor = UIColor.clear
        ted.frame = self.view.bounds.insetBy(dx: 20, dy: 50)
        self.view.addSubview(ted)
        self.view.backgroundColor = UIColor.green
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

