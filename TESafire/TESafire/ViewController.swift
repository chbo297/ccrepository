//
//  ViewController.swift
//  TESafire
//
//  Created by bo on 10/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let safire = SFSafariViewController.init(url: URL.init(string: "https://www.baidu.com")!)
        self.present(safire, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

