//
//  ViewController.swift
//  TERepresentLayer
//
//  Created by bo on 16/05/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let layaa = CALayer.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layer = self.layaa
        self.view.layer.addSublayer(layer)
        
        layer.backgroundColor = UIColor.red.cgColor
        layer.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let anim = CABasicAnimation.init(keyPath: "position")
        anim.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 0, y: 0))
        anim.toValue = NSValue.init(cgPoint: CGPoint.init(x: 320, y: 500))
        anim.duration = 8
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        
        layaa.add(anim, forKey: "ani")
        
        
        let disp = CADisplayLink.init(target: self, selector: #selector(prpr))
        disp.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    func prpr() {
        print("zhen:\(layaa.position)")
        print("\(layaa.presentation()?.position)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

