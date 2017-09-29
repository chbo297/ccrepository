//
//  UIImage+CC.swift
//  TEImageOperation
//
//  Created by bo on 26/09/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

import UIKit

extension UIImage {
    //切图
    func cc_getClipSubImage(rect : CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let drawrect = CGRect.init(x: -rect.origin.x, y: -rect.origin.y, width: self.size.width, height: self.size.height)
        self.draw(in: drawrect)
        let newimg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let sni = newimg {
            return sni
        } else {
            return UIImage.init()
        }
    }
    
    class func cc_image(gradientColors : [UInt32],
                        direction : (startPoint : CGPoint, endPoint : CGPoint) = (CGPoint.init(x: 0, y: 0.5), CGPoint.init(x: 1, y: 0.5)),
                        corner : (corners : UIRectCorner, radius : CGFloat) = (UIRectCorner.init(rawValue: 0), 0),
                        border : (width : CGFloat, color : UIColor) = (0, UIColor.clear),
                        size : CGSize) -> UIImage {
        var boundingRect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(boundingRect.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage.init()
        }
        
        if (border.width > 0) {
            let bof = border.width/CGFloat(2)
            boundingRect = boundingRect.insetBy(dx: bof, dy: bof)
        }
        
        let cornerspath = UIBezierPath.init(roundedRect: boundingRect,
                                            byRoundingCorners: corner.corners,
                                            cornerRadii: CGSize.init(width: corner.radius, height: corner.radius))
        let path = cornerspath.cgPath
        context.addPath(path)
        context.clip()
        
        var ucolorar = gradientColors
        if ucolorar.count == 1 {
            ucolorar.append(ucolorar[0])
        }
        
        let rgb = CGColorSpaceCreateDeviceRGB()
        let divisor = CGFloat(255)
        
        var colors : [CGFloat] = []
        for (_, hexcolor) in ucolorar.enumerated() {
            let red     = CGFloat((hexcolor & 0xFF000000) >> 24) / divisor
            let green   = CGFloat((hexcolor & 0x00FF0000) >> 16) / divisor
            let blue    = CGFloat((hexcolor & 0x0000FF00) >>  8) / divisor
            let alpha   = CGFloat( hexcolor & 0x000000FF       ) / divisor
            
            colors.append(contentsOf: [red, green, blue, alpha])
            
        }
        guard let cggradient = CGGradient.init(colorSpace: rgb, colorComponents: colors, locations: nil, count: ucolorar.count) else {
            return UIImage.init()
        }
        
        let sp = CGPoint.init(x: boundingRect.size.width * direction.startPoint.x, y: boundingRect.size.height * direction.startPoint.y)
        let ep = CGPoint.init(x: boundingRect.size.width * direction.endPoint.x, y: boundingRect.size.height * direction.endPoint.y)
        
        context.drawLinearGradient(cggradient,
                                   start: sp, end: ep,
                                   options: CGGradientDrawingOptions.drawsBeforeStartLocation.union(.drawsAfterEndLocation))
        
        if border.width > 0 {
            context.resetClip()
            context.addPath(path)
            context.setStrokeColor(border.color.cgColor)
            context.setLineWidth(border.width)
            context.strokePath()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let retig = image {
            return retig.resizableImage(withCapInsets: UIEdgeInsets.init(top: corner.radius, left: corner.radius, bottom: corner.radius, right: corner.radius),
                                        resizingMode: .stretch)
        } else {
            //some thing wrong
            return UIImage.init()
        }
    }
    
}
