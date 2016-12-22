//
//  CCDetailViewController.swift
//  CCGitHubPro
//
//  Created by bo on 20/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit
//import SnapKit

class CCDetailViewController: UIViewController {
    
    
//    func setZoomTransition(originalView : UIView) {
//        self.modalPresentationStyle = .custom
//        let transitioner = CCZoomTransitioner()
//        transitioner.transitOriginalView = originalView
//        self.cc_transitioner = transitioner
//        self.transitioningDelegate = self.cc_transitioner
//    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let label = UILabel.init()
        
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Content"
        label.sizeToFit()
        let size = self.view.bounds.size
        label.center = CGPoint.init(x: size.width/2, y: size.height/2)
        self.view.addSubview(label)
        
        let closebutton = UIButton.init()
        closebutton.setTitle("←", for: .normal)
        closebutton.setTitleColor(UIColor.black, for: .normal)
        closebutton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        
        closebutton.sizeToFit()
        self.view.addSubview(closebutton)
        
        closebutton.addTarget(self, action: #selector(self.tapClose(sender:)), for: .touchUpInside)
        
        
    }
    
    func tapClose(sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
