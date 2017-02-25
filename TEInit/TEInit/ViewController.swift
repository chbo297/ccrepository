//
//  ViewController.swift
//  TEInit
//
//  Created by bo on 13/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dd : TEDealloc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let son = Son.init(fa1 : 4)
        son.display()
        let dede = TEDealloc()
        dd = dede
        Thread.detachNewThread { 
            dede.play()
        }
//        let dis = DispatchQueue.global(qos: .background)
//        dis.sync {
//            
//            
//        }
        
        dede.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dd = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



class TEDealloc: NSObject {
    
    func play() {
        print("play:\(Thread.current)")
    }
    
    deinit {
        
        print("deinit:\(Thread.current)")
    }
}

