//
//  beginVC.swift
//  TECamera
//
//  Created by bo on 21/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class beginVC: UIViewController {

    @IBOutlet weak var imagev: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.imagev.transform = CGAffineTra nsform.init(rotationAngle: CGFloat(Double.pi)/2)
    }
    

    @IBAction func bubu(_ sender: Any) {
        
        let viewController = ViewController.init(nibName: nil, bundle: nil)
        
        viewController.callBack = { face  in
            self.imagev.image = face
        }
        self.present(viewController, animated: true, completion: nil)
    }

}
