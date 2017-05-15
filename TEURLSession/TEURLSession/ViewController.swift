//
//  ViewController.swift
//  TEURLSession
//
//  Created by bo on 06/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }

    @IBAction func bubu(_ sender: Any) {
        
//        self.session.dataTask(with: url :)
        let url = URL.init(string: "http://gss0.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/zhidao/wh%3D800%2C450/sign=1e3768eec03d70cf4cafa205c8ecfd34/adaf2edda3cc7cd9ec190e0e3001213fb80e9134.jpg")!
        let request = URLRequest.init(url: url)
//        URLRequest.init(url: <#T##URL#>, cachePolicy: <#T##URLRequest.CachePolicy#>, timeoutInterval: <#T##TimeInterval#>)
//        self.session.dataTask(with: url) { (data, _, error) in
//            print("\(String(describing: data))\n error\(String(describing: error))")
//        }.resume()
        
        self.session.uploadTask(with: request, from: nil) { (data, _, error) in
            print("\(String(describing: data))\n error\(String(describing: error))")
            }.resume()
        self.session.get
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

