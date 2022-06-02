//
//  Animator.swift
//  WeatherApp
//
//  Created by user on 31/07/2019.
//  Copyright © 2019 Morizo Digital. All rights reserved.
//

import UIKit

class FullScreenAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let interactiveTransition = UIPercentDrivenInteractiveTransition()

    let transitionTime = 1.0

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionTime
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        if let mainViewController = transitionContext.viewController(forKey: .from),
           let fullScreenViewController = transitionContext.viewController(forKey: .to) as? FullScreenImageViewController {

            containerView.addSubview(fullScreenViewController.view)
            showAnimation(mainViewController, fullScreenViewController, transitionContext)

        } else if let fromViewController = transitionContext.viewController(forKey: .from) as? FullScreenImageViewController,
                  let toViewController = transitionContext.viewController(forKey: .to) {

            showDisAnimation(fromViewController, toViewController, transitionContext)

        }



    }

    private func showAnimation(_ fromViewController: UIViewController, _ toViewController: FullScreenImageViewController, _ transitionContext: UIViewControllerContextTransitioning) {

        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let fullScreenFrame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        toViewController.interactiveTransition = interactiveTransition
        toViewController.imageView.frame = toViewController.startFrame
        toViewController.view.alpha = 0

        // Just the animation of the tempImage
        UIView.animateKeyframes(withDuration: transitionTime, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.90) {
                UIView.animate(withDuration: 0.90, animations: {
                    toViewController.imageView.frame = fullScreenFrame
                })
            }

            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.10) {
                UIView.animate(withDuration: 0.10, animations: {
                    toViewController.view.alpha = 1
                })
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }


    private func showDisAnimation(_ fromViewController: FullScreenImageViewController, _ toViewController: UIViewController , _ transitionContext: UIViewControllerContextTransitioning) {

        fromViewController.view.alpha = 1

                UIView.animateKeyframes(withDuration: transitionTime, delay: 0, options: .calculationModeLinear, animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.90) {
                        UIView.animate(withDuration: 0.90, animations: {
                            fromViewController.imageView.frame = fromViewController.startFrame
                        })
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.10) {
                        UIView.animate(withDuration: 0.10, animations: {
                            fromViewController.view.alpha = 0
                        })
                    }
                }, completion: { _ in
                    transitionContext.completeTransition(true)

                })
    }

    deinit {
        print ("deinit")
    }
}
