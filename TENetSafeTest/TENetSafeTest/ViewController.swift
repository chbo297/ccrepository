//
//  ViewController.swift
//  TENetSafeTest
//
//  Created by bo on 27/09/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var textV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onbut(_ sender: Any) {
        let dic =  ["key1":"value1", "key2":"value2"]
        self.textV.text = "loading\n发送：\(dic.debugDescription)"
        self.netManager.post("test", parameters: dic, progress: nil, success: { (task, obj) in
            let jsj = JSON(obj!)
//            if let jsj =  {
                self.textV.text = "发送：\n\(JSON(dic).debugDescription)\n接收:\(jsj.debugDescription)"
                print("\(jsj)")
//            }
            
        }) { (task, error) in
            self.textV.text = error.localizedDescription
            print("\(error.localizedDescription)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let netManager : AFHTTPSessionManager = {
        
        guard let cerpath = Bundle.main.path(forResource: "101.200.58.6", ofType: "cer") else {
            fatalError("file not exist")
        }
        
        guard let cerdata = try? Data.init(contentsOf: URL.init(fileURLWithPath: cerpath)) else {
            fatalError("file not exist")
        }
        
        var certset = Set<Data>.init()
        certset.insert(cerdata)
        
        let manager = AFHTTPSessionManager.init(baseURL: URL.init(string: "https://101.200.58.6"), sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer = AFJSONRequestSerializer.init()
        manager.requestSerializer.timeoutInterval = 10
        let secpo = AFSecurityPolicy.init(pinningMode: AFSSLPinningMode.certificate, withPinnedCertificates: certset)
        secpo.allowInvalidCertificates = true
        manager.securityPolicy = secpo
        
        return manager
    }()


}




