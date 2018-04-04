//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Sam Beedell on 04/04/2018.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true // false = dismissing
    var originFrame = CGRect.zero
    var dismissCompletion: ( () -> Void )?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // Time it take to complete the animation
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Animation Code
        let containerView = transitionContext.containerView // this is where the animations take place
        let toView = transitionContext.view(forKey: .to)! // access to transition players
        
        if presenting {
            // Force a layout pass to ensure the frame is correct to the current device (not xib)
            let w = UIScreen.main.bounds.width
            let h = UIScreen.main.bounds.height
            toView.frame = CGRect(x: 0 , y: 0 , width: w * 0.75, height: h * 0.75)
            toView.center = CGPoint(x: w / 2, y: h / 2)
        }
        
        // Pop Transition
        let itemView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : itemView.frame
        let finalFrame = presenting ? itemView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        // Scale and position the new view to exactly the initial frame
        if presenting {
            itemView.transform = scaleTransform
            itemView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            itemView.clipsToBounds = true
        }

        containerView.addSubview(toView)
        containerView.bringSubview(toFront: itemView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5,
                       animations: {
                        itemView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        itemView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        },
                       completion: { _ in
                        if !self.presenting {
                            self.dismissCompletion?()
                        }
                        transitionContext.completeTransition(true)
        }
        )

    }
}
