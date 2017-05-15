//
//  ViewController.swift
//  TEPan
//
//  Created by bo on 06/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let panvie = PanView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(panvie)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

