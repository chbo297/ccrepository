//
//  ViewController.swift
//  TERespinseChains
//
//  Created by bo on 01/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let abc : String
    
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.abc = "as"
        print("\(self.abc)")
        print("\(abc)")
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.abc = "as"
//        print("\(self)")
        print("\(abc)")
        super.init(coder: aDecoder)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

