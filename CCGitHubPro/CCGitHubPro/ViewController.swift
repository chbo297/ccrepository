//
//  ViewController.swift
//  CCGitHubPro
//
//  Created by bo on 17/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit
//import GDPerformanceMonitor
import GDPerformanceView
//import TSTestSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GDPerformanceMonitor.sharedInstance()!.startMonitoring()
//        GDPerformanceView().resumeMonitoring()
        
        
//        let bu = UIButton.init()
//        
//        let an = bu as AnyObject
//        
//         let isst = an as? UIButton
//        
//            print(isst!)
//        
//        //else
//        
//            print("nini")
//        var str = "abcde"
//        let a = str.index(str.startIndex, offsetBy: 3)
//        str.insert(Character.init("h"), at: a)
//        print(str)
//        
//        let aa : Int? = 1
//        print(aa!)
        
//        let a : NSString? = nil
//        if let b = a {
//            print("yes/(b)")
//        } else {
//            print("nini")
//        }
        
//        let view : UIView? = UIView()
//        
//        print("\(view?.frame)")
        
        
        
//        for (index, item) in ar.enumerated() {
//            print("\(index),\(item)")
//        }
        
        
       // ar.append("a")
        
//        let obj = TSSubClass.init(par: 1)
//        print(obj.name)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

