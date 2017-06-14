//
//  ViewController.swift
//  TEViewDrewLine
//
//  Created by bo on 10/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var v1: UIView!

    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.v1.layer.borderColor = UIColor.white.cgColor
        self.v2.layer.borderColor = UIColor.white.cgColor
        self.v3.layer.borderColor = UIColor.white.cgColor
        self.v4.layer.borderColor = UIColor.white.cgColor
        
        self.v1.layer.borderWidth = 20
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

