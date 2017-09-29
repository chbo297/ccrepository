//
//  ViewController.swift
//  TEObserveAndNotificaRelease
//
//  Created by bo on 03/07/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var o1 : TEObj1?
    var o2 : TEObj2?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        o1 = TEObj1()
        o2 = TEObj2()
        
        NotificationCenter.default.addObserver(o2!, selector: #selector(o2?.notificationReceive), name: NSNotification.Name(rawValue: "gaga"), object: nil)
        NotificationCenter.default.addObserver(o2!, selector: #selector(o2?.notificationReceive), name: NSNotification.Name(rawValue: "gaga"), object: nil)
        
//        o1!.addObserver(o2!, forKeyPath: "name", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        
    }

    @IBOutlet weak var do2: UIButton!
    @IBAction func `do`(_ sender: Any) {
//        self.o1!.name += "a"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gaga"), object: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func do2s(_ sender: Any) {
        
        self.o2 = nil
    }
}

