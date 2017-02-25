//
//  ViewController.swift
//  TEBounds
//
//  Created by bo on 26/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit
import CCZoomTransition

class ViewController: UIViewController {

    var teView = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
    
    var vvc = CViewController.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        teView.backgroundColor = UIColor.blue
        self.view.addSubview(teView)
        
        let sview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        teView.addSubview(sview)
        sview.backgroundColor = UIColor.yellow
        
    }
    @IBAction func buton(_ sender: Any) {
//        teView.bounds = CGRect.init(x: -10, y: -10, width: 100, height: 100)
        
//        let vc = UIViewController()
        vvc.view.backgroundColor = UIColor.gray
        vvc.cc_setZoomTransition(originalView: teView)
        self.present(vvc, animated: true, completion: nil)
    }

    @IBOutlet weak var bu: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

