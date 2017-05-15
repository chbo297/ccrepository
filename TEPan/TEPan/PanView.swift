//
//  PanView.swift
//  TEPan
//
//  Created by bo on 06/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class PanView: UIView {

    var panGes : UIPanGestureRecognizer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        let downges = UISwipeGestureRecognizer.init(target: self, action: #selector(self.handleSwipes(sender:)))
        downges.direction = .down
        let upges = UISwipeGestureRecognizer.init(target: self, action: #selector(self.handleSwipes(sender:)))
        upges.direction = .up
        self.addGestureRecognizer(downges)
        self.addGestureRecognizer(upges)
//        self.panGes = UIPanGestureRecognizer.init(target: self, action: #selector(self.pan(ges:)))
        
        
        
        
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizerDirection.left {
            print("Left")
        }
        if sender.direction == UISwipeGestureRecognizerDirection.right {
            print("Right")
        }
        if sender.direction == UISwipeGestureRecognizerDirection.up {
            print("Up")
        }
        if sender.direction == UISwipeGestureRecognizerDirection.down {
            print("Down")
        }
    }
    
//    func pan(ges : UIPanGestureRecognizer) {
//        switch ges.state {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
