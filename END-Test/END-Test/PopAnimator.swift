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
        
        // Pop Transition
        //let itemView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        // access to transition players
        var itemView: UIView
        if presenting {
            guard let toView = transitionContext.view(forKey: .to) else {
                print("no toView in custom 'Pop' segue animation script?")
                return
            }
            // Force a layout pass to ensure the frame is correct to the current device (not xib)
            toView.frame = UIScreen.main.bounds
            itemView = toView
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else {
                print("no fromView in custom 'Pop' segue animation script?")
                return
            }
            itemView = fromView
        }
        
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

        containerView.addSubview(itemView)
        containerView.bringSubview(toFront: itemView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2,
                       animations: {
                        itemView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        itemView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        },
                       completion: { _ in
                        if !self.presenting {
                            self.dismissCompletion?()
                        }
                        transitionContext.completeTransition(true)
        })
    }
}
