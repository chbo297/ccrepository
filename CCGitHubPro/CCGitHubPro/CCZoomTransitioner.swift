//
//  CCZoomTransitioner.swift
//  CCGitHubPro
//
//  Created by bo on 20/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit



class CCZoomTransitioner : NSObject, UIViewControllerTransitioningDelegate {
    
    var transitOriginalView : UIView? = nil
    var presentationController : CCSwipBackPresentationController? = nil
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let trans = CCZoomAnimatedTransitioning()
        trans.transitOriginalView = self.transitOriginalView;
        trans.isPresentation = true;
        return trans;
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let trans = CCZoomAnimatedTransitioning()
        trans.transitOriginalView = self.transitOriginalView;
        trans.isPresentation = false;
        return trans;
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.presentationController?.swipBackTransitioning
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        self.presentationController = CCSwipBackPresentationController.init(presentedViewController: presented, presenting: presenting)
        return self.presentationController
    }
}

class CCSwipBackPresentationController : UIPresentationController {
    
    private(set) var swipBackTransitioning: UIPercentDrivenInteractiveTransition? = nil
    
    func edgePan(panGes : UIScreenEdgePanGestureRecognizer) {
        if let container = panGes.view {
            switch panGes.state {
            case .began:
                if (nil == self.swipBackTransitioning &&
                    !self.presentingViewController.isBeingPresented &&
                    !self.presentedViewController.isBeingDismissed) {
                    self.swipBackTransitioning = UIPercentDrivenInteractiveTransition()
                    self.swipBackTransitioning?.completionCurve = .easeOut
                    self.presentingViewController.dismiss(animated: true, completion: nil)
                }
                
            case .changed:
                let translation = panGes.translation(in: container)
                var width : CGFloat = container.bounds.width
                if (width <= 0) { width = 300 }
                let d = translation.x > 0 ? (translation.x / width) : 0
                self.swipBackTransitioning?.update(d)
                
            case .ended, .cancelled, .failed:
                if (nil != self.swipBackTransitioning) {
                    if (panGes.velocity(in: container).x > 0 || self.swipBackTransitioning!.percentComplete > 0.5) {
                        self.swipBackTransitioning?.finish()
                    } else {
                        self.swipBackTransitioning?.cancel()
                    }
                    self.swipBackTransitioning = nil
                }
                
            default:
                return
            }
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        let ges = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(self.edgePan(panGes:)))
        ges.edges = UIRectEdge.left
        self.containerView?.addGestureRecognizer(ges)
        
    }
}
class CCZoomAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitOriginalView : UIView? = nil
    
    var isPresentation : Bool = true
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let animateComplete = {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        var fromVC : UIViewController
        var toVC : UIViewController
        
        if let vc = transitionContext.viewController(forKey:.from) {
            fromVC = vc
        } else {
            animateComplete()
            return
        }
        
        if let vc = transitionContext.viewController(forKey:.to) {
            toVC = vc
        } else {
            animateComplete()
            return
        }
        
        let fromView = fromVC.view!
        let toView = toVC.view!
        
        let containerView = transitionContext.containerView
        let toFrame : CGRect = {
            var frame = transitionContext.finalFrame(for:toVC)
            
            if frame.isEmpty {
                frame = containerView.frame
            }
            
            return frame
        }()
        
        toView.frame = toFrame
        
        let transitview = (self.transitOriginalView ?? (self.isPresentation ? fromView : toView))!
        
        let originrect = containerView.convert(transitview.frame, from: transitview.superview)
        
        let shadow = UIImageView();
        
        var transitimage : UIImage? = nil;
        
        if transitview is UIImageView {
            
            let imagev = transitview as! UIImageView
            transitimage = imagev.image
        } else {
            
            transitimage = self.snapshotView(view: transitview)
        }
        
        if (self.isPresentation)
        {
            //get toview snapshot
            
            let tranimage : UIImage = {
                if let image  = self.snapshotView(view: toView) {
                    return image
                } else {
                    return self.imageWithColor(color: UIColor.init(white: 0.3, alpha: 0.3)) ?? UIImage()
                }
            }()
            
            let savetoViewalpha = toView.alpha
            toView.alpha = 0;
            containerView.addSubview(toView)
            
            shadow.frame = originrect;
            shadow.backgroundColor = UIColor.clear;
            containerView.addSubview(shadow)
            
            let blurshadow = UIImageView.init(image: tranimage)
            blurshadow.contentMode = .scaleToFill;
            blurshadow.frame = shadow.bounds;
            blurshadow.alpha = 0;
            shadow.addSubview(blurshadow)
            
            let transitvshadow = UIImageView.init(image: transitimage)
            transitvshadow.contentMode = .scaleAspectFill;
            transitvshadow.frame = shadow.bounds;
            shadow.addSubview(transitvshadow)
            shadow.clipsToBounds = true;
            
            let savetransitviewhidden = transitview.isHidden;
            transitview.isHidden = true;
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                    delay: 0,
                                    options: .calculationModeCubic,
                                    animations: {
                                        //shadow
                                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: { 
                                            shadow.frame = containerView.bounds;
                                            blurshadow.frame = shadow.bounds;
                                            transitvshadow.frame = shadow.bounds;
                                        })
                                        
                                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: { 
                                            transitvshadow.alpha = 0;
                                            blurshadow.alpha = 1;
                                        })
                                        
                                        UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 1, animations: {
                                            toView.alpha = 1
                                        })
                                        
            },
                                    completion: { (finish) in
                                        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .calculationModeCubic,
                                                                animations: { 
                                                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,
                                                                                       animations: { 
                                                                                        blurshadow.alpha = 0
                                                                    })
                                        },
                                                                completion: { (finish) in
                                                                    shadow.removeFromSuperview()
                                                                    toView.alpha = savetoViewalpha
                                                                    transitview.isHidden = savetransitviewhidden
                                                                    animateComplete()
                                        })
            })
            
        }
        else
        {
//            containerView.insertSubview(toView, belowSubview: fromView)
            
            shadow.frame = fromView.frame;
            containerView.addSubview(shadow)
            
            shadow.backgroundColor = UIColor.clear;
            let fromvshadow : UIImageView = {
                let imageview = UIImageView.init(image: self.snapshotView(view: fromView))
                imageview.contentMode = .scaleToFill
                imageview.frame = shadow.bounds
                return imageview
            }()
            shadow.addSubview(fromvshadow)
            
            let transitvshadow : UIImageView = {
                let imageview = UIImageView.init(image: transitimage)
                imageview.contentMode = .scaleAspectFill
                imageview.alpha = 0
                imageview.frame = shadow.bounds
                return imageview
            }()
            shadow.addSubview(transitvshadow)
            shadow.clipsToBounds = true
            
            let savefromviewalpha = fromView.alpha
            fromView.alpha = 0
            
            let savetransitviewalpha = transitview.alpha
            transitview.alpha = 0;
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                    delay: 0,
                                    options: .calculationModeLinear,
                                    animations: { 
                                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,
                                                           animations: { 
                                                            shadow.frame = originrect;
                                                            transitvshadow.frame = shadow.bounds;
                                                            fromvshadow.frame = shadow.bounds;
                                        })
                                        
                                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7,
                                                           animations: {
                                                            transitvshadow.alpha = 0.2;
                                        })
                                        
                                        UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.8,
                                                           animations: {
                                                            transitvshadow.alpha = 0.5;
                                                            fromvshadow.alpha = 0.5;
                                        })
                                        
                                        UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 1,
                                                           animations: {
                                                            transitvshadow.alpha = 1;
                                                            transitview.alpha = savetransitviewalpha;
                                        })
                                        
                                        
            },
                                    completion: { (finish) in
                                        shadow.removeFromSuperview()
                                        transitview.alpha = savetransitviewalpha;
                                        fromView.alpha = savefromviewalpha;
                                        animateComplete()
            })
        }
    }
    
}

extension CCZoomAnimatedTransitioning {
    
    func snapshotView(view : UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let retImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return retImage
        }
        
        return nil
    }
    
    func imageWithColor(color : UIColor) -> UIImage? {
        let size = CGSize.init(width: 1, height: 1)
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect.init(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image
    }
    
}

extension UIViewController {
    
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
    
    func setZoomTransition(originalView : UIView) {
        self.modalPresentationStyle = .custom
        let transitioner = CCZoomTransitioner()
        transitioner.transitOriginalView = originalView
        self.cc_transitioner = transitioner
        self.transitioningDelegate = self.cc_transitioner
    }
    
    
}

