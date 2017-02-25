//
//  ViewController.swift
//  TEOpenGL
//
//  Created by bo on 02/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit
import GLKit
import OpenGLES

class ViewController: UIViewController {

    let glContext : EAGLContext = EAGLContext.init(api: .openGLES2)
    let esView : GLKView
    let esLayer = CAEAGLLayer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        esView = GLKView.init(frame: CGRect.zero, context: glContext)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        GLKView()
        esView = GLKView.init(frame: CGRect.zero, context: glContext)
//        CAAnimation
//        CABasicAnimation
//        CAKeyframeAnimation
//        CATransition
//        esView.drawableColorFormat
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.green
        esView.frame = self.view.bounds.insetBy(dx: 10, dy: 45)
        let drawv = TEDrawView.init(frame : self.view.bounds.insetBy(dx: 10, dy: 45))
        self.view.addSubview(drawv)
        
        let grayv = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 30, height: 40))
        grayv.backgroundColor = UIColor.gray
        drawv.layer.addSublayer(grayv.layer)
        print("\(drawv.layer.contents)")
        drawv.layer.contents = UIImage.init(named: "wjn")?.cgImage
//        drawv.addSubview(grayv)
        
//        self.view.addSubview(self.esView)
//        esLayer.frame = self.view.bounds.insetBy(dx: 10, dy: 45)
//        self.view.layer.addSublayer(esLayer)
//        glClearColor(0.5, 0.5, 0.5, 1.0)
//        
//        
//        esLayer.drawableProperties = [
//            AnyHashable(kEAGLDrawablePropertyRetainedBacking) : true,
//            AnyHashable(kEAGLDrawablePropertyColorFormat) : kEAGLColorFormatRGBA8,
//        ]
////        GL_COLOR_BUFFER_BIT
//        glClear();
//        glContext.presentRenderbuffer(3)
        esView.context = glContext
        EAGLContext.setCurrent(glContext)
        
        
//        esLayer.setconte
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        glClearColor(0.5, 0.5, 0.5, 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

