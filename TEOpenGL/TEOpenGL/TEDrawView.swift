//
//  TEDrawView.swift
//  TEOpenGL
//
//  Created by bo on 09/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class TEDrawView: UIView {

    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.contents = UIImage.init(named: "wjn")?.cgImage
        let berz = UIBezierPath.init(ovalIn: rect)
        berz.lineWidth = 2
        UIColor.red.setStroke()
        UIColor.yellow.setFill()
        berz.fill()
        berz.stroke()
        print("indraw:\(self.layer.contents)")
        self.layer.contents = UIImage.init(named: "wjn")?.cgImage
    }
 

}
