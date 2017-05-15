//
//  ViewController.swift
//  TECamera
//
//  Created by bo on 21/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let backView : UIView = {
        let tag = UIView.init()
        return tag
    }()
    
    let frontView : UIView = {
        let tag = UIView.init()
        return tag
    }()
    
    let leftTag : UIView = {
        let tag = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        tag.backgroundColor = UIColor.green
        return tag
    }()
    
    let rightTag : UIView = {
        let tag = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        tag.backgroundColor = UIColor.green
        return tag
    }()
    
    let moTag : UIView = {
        let tag = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        tag.backgroundColor = UIColor.green
        return tag
    }()
    
    let clipImage = UIImageView.init()
    
    var callBack :((_ face: UIImage) ->())?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    let captureSession = AVCaptureSession()
    var pickUIImager : UIImageView = UIImageView(image: UIImage(named: "pick_bg"))
    var line : UIImageView = UIImageView(image: UIImage(named: "line"))
    var timer : Timer!
    var upOrdown = true
    var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.backView)
        
        self.backView.frame = self.view.bounds
        
        self.view.addSubview(self.frontView)
//        CATransform3D
//        self.frontView.layer.transform = catran
//        self.frontView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi)/2)
//        self.frontView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
//        self.frontView.transform = CGAffineTransform.init(translationX: 30, y: 60)
        
        self.view.addSubview(self.leftTag)
        self.view.addSubview(self.rightTag)
        self.view.addSubview(self.moTag)
        self.frontView.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
        
        self.view.addSubview(self.clipImage)
        
        self.clipImage.frame = CGRect.init(x: 225, y: 0, width: 150, height: 150)
        self.clipImage.backgroundColor = UIColor.lightGray
        
        // Do any additional setup after loading the view, typically from a nib.
        self.captureSession.sessionPreset = AVCaptureSessionPreset640x480
        let devicesession = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera],
                                                                 mediaType: AVMediaTypeVideo,
                                                                 position: AVCaptureDevicePosition.front)
        
        if let devicear = devicesession?.devices {
            for device in devicear {
                if device.hasMediaType(AVMediaTypeVideo) {
                    self.captureDevice = device
                    self.beginSession()
                }
            }
        }
        
        pickUIImager.frame = CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 100,width: 200,height: 200)
        line.frame = CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 100, width: 200, height: 2)
//        self.view.addSubview(pickUIImager)
//        self.view.addSubview(line)
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.animationSate), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.isStartTrue), userInfo: nil, repeats: false)
    }
    
    func isStartTrue(){
        self.isStart = true
    }

    func animationSate(){
        if upOrdown {
            if (line.frame.origin.y >= pickUIImager.frame.origin.y + 200)
            {
                upOrdown = false
            }
            else
            {
                line.frame.origin.y += 2
            }
        } else {
            if (line.frame.origin.y <= pickUIImager.frame.origin.y)
            {
                upOrdown = true
            }
            else
            {
                line.frame.origin.y -= 2
            }
        }
    }

    func beginSession() {
        try? captureSession.addInput(AVCaptureDeviceInput.init(device: captureDevice))
        let output = AVCaptureVideoDataOutput()
        let cameraqueue = DispatchQueue.init(label: "cameraQueue")
        output.setSampleBufferDelegate(self, queue: cameraqueue)
        output.videoSettings = [String(kCVPixelBufferPixelFormatTypeKey): kCVPixelFormatType_32BGRA]
        
        
        captureSession.addOutput(output)
        
        let conn = output.connection(withMediaType: AVMediaTypeVideo)
        if conn!.isVideoOrientationSupported {
            conn?.videoOrientation = .portrait
        }
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = "AVLayerVideoGravityResizeAspect"
        previewLayer?.frame = CGRect.init(x: 0, y: 0, width: 480, height: 640)
        self.backView.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        if(self.isStart)
        {
            let resultImage = sampleBufferToImage(sampleBuffer)
            
            let context = CIContext(options:[kCIContextUseSoftwareRenderer:true])
            let detecotr = CIDetector(ofType:CIDetectorTypeFace,  context:context, options:[CIDetectorAccuracy: CIDetectorAccuracyHigh])
            
            
            
            
            let ciImage = CIImage(image: resultImage)!
            let results = detecotr?.features(in: ciImage, options: ["CIDetectorImageOrientation" : 1])
            CIFilter.init(name: <#T##String#>, withInputParameters: <#T##[String : Any]?#>)
            let ciImageSize = ciImage.extent.size
            var transform = CGAffineTransform(scaleX: -1, y: -1)
            transform = transform.translatedBy(x: -ciImageSize.width, y: -ciImageSize.height)
            for (_, r) in results!.enumerated() {
                let face:CIFaceFeature = r as! CIFaceFeature;
                var faceImage = UIImage.init(cgImage: context.createCGImage(ciImage, from: face.bounds)!, scale: 1, orientation: UIImageOrientation.up)
                DispatchQueue.main.async {
                self.clipImage.image = faceImage
                }
                print("bounds:\(NSValue.init(cgRect: face.bounds))")
                print("properties:\(ciImage.properties)")
//                NSValue.init(cgPoint: <#T##CGPoint#>)
                print("leftEyePosition:\(NSValue.init(cgPoint: face.leftEyePosition))")
                print("rightEyeClosed:\(NSValue.init(cgPoint: face.rightEyePosition))")
                print("mouthPosition:\(NSValue.init(cgPoint: face.mouthPosition))")
                
                NSLog("Face found at (%f,%f) of dimensions %fx%f", face.bounds.origin.x, face.bounds.origin.y,pickUIImager.frame.origin.x, pickUIImager.frame.origin.y)
                
                DispatchQueue.main.async {
                    var facebon = face.bounds.applying(transform)
                    facebon.size.height *= 1.1
                    self.frontView.frame = facebon}
                
                let boundingRect = CGRect.init(x: 0, y: 0, width: faceImage.size.width, height: faceImage.size.height)
                
                if boundingRect.isEmpty == false {
//                    UIGraphicsBeginImageContextWithOptions(boundingRect.size, false, UIScreen.main.scale);
//                    let context = UIGraphicsGetCurrentContext()!;
//                    context.draw(faceImage.cgImage!, in: boundingRect)
                    if face.hasLeftEyePosition {
                        let point = face.leftEyePosition
                        DispatchQueue.main.async {
                            self.leftTag.center = point.applying(transform)}
//                        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: point.x - face.bounds.origin.x, y: point.y - face.bounds.origin.y), radius: 3, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: true)
//                        
//                        context.addPath(path.cgPath)
//                        context.setFillColor(UIColor.green.cgColor)
//                        context.fillPath()
//                        faceImage = UIGraphicsGetImageFromCurrentImageContext()!
                    }
                    
                    if face.hasRightEyePosition {
                        let point = face.rightEyePosition
                        DispatchQueue.main.async {
                            self.rightTag.center = point.applying(transform)}
//                        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: point.x - face.bounds.origin.x, y: point.y - face.bounds.origin.y), radius: 3, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: true)
//                        
//                        context.addPath(path.cgPath)
//                        context.setFillColor(UIColor.green.cgColor)
//                        context.fillPath()
//                        faceImage = UIGraphicsGetImageFromCurrentImageContext()!
                    }
                    
                    if face.hasMouthPosition {
                        let point = face.mouthPosition
                        DispatchQueue.main.async {
                            self.moTag.center = point.applying(transform)}
//                        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: point.x - face.bounds.origin.x, y: point.y - face.bounds.origin.y), radius: 3, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: true)
//                        
//                        context.addPath(path.cgPath)
//                        context.setFillColor(UIColor.green.cgColor)
//                        context.fillPath()
//                        faceImage = UIGraphicsGetImageFromCurrentImageContext()!
                    }
                    
                }
                
                
                
                
                
                
//                DispatchQueue.main.async {
//                    if (self.isStart)
//                    {
//                        self.dismiss(animated: true, completion: nil)
//                        
//                        self.callBack!(faceImage)
//                    }
//                    self.isStart = false
//                }
//
//                dispatch_async(dispatch_get_main_queue()) {
//                    if (self.isStart)
//                    {
//                        self.dismissViewControllerAnimated(true, completion: nil)
//                        self.didReceiveMemoryWarning()
//                        
//                        self.callBack!(face: faceImage!)
//                    }
//                    self.isStart = false
//                }
            }
        }
    }
    
    private func sampleBufferToImage(_ sampleBuffer: CMSampleBuffer!) -> UIImage {
        let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let baseAddress = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitsPerCompornent = 8
        let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) as UInt32)
        
        
        let newContext = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: bitsPerCompornent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        let imageRef: CGImage = newContext.makeImage()!
        let resultImage = UIImage.init(cgImage: imageRef, scale: 1, orientation: .right)
        
        return resultImage
    }
    

}

