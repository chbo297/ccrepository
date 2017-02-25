//
//  CCZoomTransitionVCExtension.swift
//  CCGitHubPro
//
//  Created by bo on 22/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //set the  presented viewController,
    //originalView: Which being tap in presenting view
    func setZoomTransition(originalView : UIView) {
        /*
         fullscreen   nei
         pagesheet   nei
         formSheet
         custom     shang
         popover   nei
         none
 */
        self.modalPresentationStyle = .overFullScreen
        self.modalPresentationCapturesStatusBarAppearance = true
        let transitioner = CCZoomTransitioner()
        transitioner.transitOriginalView = originalView
        self.cc_transitioner = transitioner
        self.transitioningDelegate = self.cc_transitioner
    }
    
    private struct AssociatedKey {
        static var ZoomTransitioner = "cc_zoomTransitioner"
    }
    
    private var cc_transitioner : CCZoomTransitioner?{
        get {
            if let transitioner = objc_getAssociatedObject(self, &AssociatedKey.ZoomTransitioner) as? CCZoomTransitioner {
                return transitioner
            } else {
                return nil
            }
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.ZoomTransitioner, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    
}
