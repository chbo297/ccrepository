//
//  ViewController.swift
//  TEPresentSwiftT
//
//  Created by bo on 16/02/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        
//        
//    }

    @IBAction func bubu(_ sender: Any) {
        let redvc = RedViewController()
        redvc.setZoomTransition(originalView: self.view)
        self.present(redvc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

