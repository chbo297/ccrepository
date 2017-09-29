//
//  ViewController.swift
//  TELayoutSubView
//
//  Created by bo on 29/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

import UIKit
import SnapKit

class TEView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("laboutsubviews")
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var vright: UIView!
    @IBOutlet weak var vbig: TEView!
    @IBOutlet weak var vgreen: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//            .inset(UIEdgeInsets.init(top: 50, left: 50, bottom: 50, right: 50))

        self.vgreen.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self.vbig)
            make.trailing.equalTo(self.vbig.snp.trailing).offset(-90)
        }
        
        
        
        
    }

    @IBAction func bu1(_ sender: Any) {
        var rect = self.vbig.bounds
//        rect.origin.x += 1
        self.vbig.bounds = rect
//        self.vright.center = CGPoint.init(x: self.vright.center.x + 1, y: self.vright.center.y)
    }


}


