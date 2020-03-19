//
//  ScaleSegue.swift
//  Sense
//
//  Created by Bob Yuan on 2020-03-19.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//
/*
import UIKit

class ScaleSegue: UIStoryboardSegue {

    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
}

extension ScaleSegue : UIViewControllerTransitioningDelegate {
    return ScaleP
}

class ScalePresentAnimator: NSObject, UIViewControllerContextTransitioning {
    var containerView: UIView
    
    var isAnimated: Bool
    
    var isInteractive: Bool
    
    var transitionWasCancelled: Bool
    
    var presentationStyle: UIModalPresentationStyle
    
    func updateInteractiveTransition(_ percentComplete: CGFloat) {
        <#code#>
    }
    
    func finishInteractiveTransition() {
        <#code#>
    }
    
    func cancelInteractiveTransition() {
        <#code#>
    }
    
    func pauseInteractiveTransition() {
        <#code#>
    }
    
    func completeTransition(_ didComplete: Bool) {
        <#code#>
    }
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        <#code#>
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        <#code#>
    }
    
    var targetTransform: CGAffineTransform
    
    func initialFrame(for vc: UIViewController) -> CGRect {
        <#code#>
    }
    
    func finalFrame(for vc: UIViewController) -> CGRect {
        <#code#>
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: .to)
        let toView = transitionContext.view(forKey: .to)
        
        if let toView = toView {
            transitionContext.containerView.addSubview(toView)
        }
        
        toView?.frame = .zero
        toView?.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        let finalFrame = transitionContext.finalFrame(for: toViewController!)
        
        UIView.animate(withDuration: duration, animations: {
            toView!.frame = finalFrame
            toView?.layoutIfNeeded()
            
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
    }
}
*/

