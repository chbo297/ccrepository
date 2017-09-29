//
//  ViewController.swift
//  TEReplicatorLayerSwift
//
//  Created by bo on 16/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let aniv = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200,
                                                  height: 200))
        aniv.center = CGPoint.init(x: self.view.bounds.midX, y: self.view.bounds.midY - 200)
        aniv.backgroundColor = UIColor.lightGray
        
        let redcircle = CALayer.init()
        redcircle.backgroundColor = UIColor.red.cgColor
        redcircle.cornerRadius = 10
        redcircle.bounds = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        redcircle.position = CGPoint.init(x: aniv.bounds.midX, y: aniv.bounds.midY)
        
        let ani = CABasicAnimation.init(keyPath: <#T##String?#>)
        
        self.view.addSubview(aniv)
        aniv.layer.addSublayer(redcircle)
        
        let replicatorv = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
        replicatorv.center = CGPoint.init(x: self.view.bounds.midX, y: self.view.bounds.midY + 200)
        replicatorv.backgroundColor = UIColor.lightGray
        
//        let replicLayer = CAReplicatorLayer.init()
//        replicLayer.addSublayer(redcircle)
//        replicatorv.layer.addSublayer(replicLayer)
//        self.view.addSubview(replicatorv)
//
//        replicatorv.layer.addSublayer(CALayer.init(layer: redcircle))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

