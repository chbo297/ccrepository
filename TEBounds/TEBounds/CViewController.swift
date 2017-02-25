//
//  CViewController.swift
//  TEBounds
//
//  Created by bo on 27/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit

class CViewController: UIViewController {

    var button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button.backgroundColor = UIColor.black
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.bubu), for: .touchUpInside)
    }

    func bubu() {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
