//
//  TEDrawtes.swift
//  TEDraw
//
//  Created by bo on 10/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class TEDrawtes: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let bezer = UIBezierPath.init(ovalIn: rect)
        bezer.lineWidth = 5
        UIColor.red.setStroke()
        UIColor.white.setFill()
        bezer.fill()
        bezer.stroke()
    }
    
    
 

}
