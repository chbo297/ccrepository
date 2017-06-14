//
//  TELabelAndLine.swift
//  TE2x3xFloatUI
//
//  Created by bo on 10/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit

class TELabelAndLine: UIView {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
    
    convenience init(width : CGFloat) {
        self.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 200))
        self.backgroundColor = UIColor.black
        
        let label = UILabel.init()
        label.text = "\(width)"
        self.addSubview(label)
        label.sizeToFit()
        label.textColor = UIColor.white
        let top = NSLayoutConstraint.init(item: label, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let centx = NSLayoutConstraint.init(item: label, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([top, centx])
        
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
