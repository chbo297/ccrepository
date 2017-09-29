//
//  ViewController.swift
//  TEImageOperation
//
//  Created by bo on 26/09/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imv = UIImageView.init()
        let immg = UIImage.cc_image(gradientColors: [0xff0000ff, 0x00ff00ff], size: CGSize.init(width: 100, height: 100));
        let immg2 = UIImage.cc_image(gradientColors: [0xff0000ff, 0x00ff00ff, 0x0000ffff, 0xffffffff], direction: (CGPoint.init(x: 0, y: 0), CGPoint.init(x: 1, y: 1)),
                                     corner: (UIRectCorner.allCorners, 10), border: (5, UIColor.black), size: CGSize.init(width: 100, height: 100))
        imv.frame = CGRect.init(x: 20, y: 20, width: 100, height: 100)
        imv.image = immg2
        self.view.addSubview(imv)
//        let img = UIImage.cc_image(gradientColors: [0xff0000ff, 0x00ff00ff], direction: <#T##(startPoint: CGPoint, endPoint: CGPoint)#>, corner: <#T##(corners: UIRectCorner, radius: CGFloat)#>, border: <#T##(width: CGFloat, color: UIColor)#>, size: <#T##CGSize#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension Array {
    func alala(_ idx : Int) -> Element {
        if idx < self.count {
            return self[idx]
        } else {
            return nil
        }
    }
}

