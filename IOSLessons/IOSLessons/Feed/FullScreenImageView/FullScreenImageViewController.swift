//
//  FullScreenImageViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 01.06.2022.
//

import UIKit


class NextImageInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

class FullScreenImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var startFrame = CGRect(x:0, y:0, width: 10, height: 10)
    var imagesCollection = [String]()
    var imageViewIndex = 0

    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    var percentage: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeUp)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //        self.navigationController?.setToolbarHidden(false, animated: true)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        switch gesture.direction {
        case .right: changeImageAnimated(to: .right)
        case .left: changeImageAnimated(to: .left)
        default: dismiss(animated: true)
        }
    }

    func changeImageAnimated(to: UISwipeGestureRecognizer.Direction) {
        guard to == .right || to == .left else { return }

        guard let currentImage = imageView else { return }

        if to == .right, imageViewIndex <= 0 {
            return
        }

        if to == .left, imageViewIndex + 1 >= imagesCollection.count {
            return
        }


        let nextImage = UIImageView()
        let nextImageIndex = imageViewIndex + (to == .left ?  1 : -1 )

        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let rightFrame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        let leftFrame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        let centerFrame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        let nextStartFrame = to == .left ? rightFrame : leftFrame;
        let prevEndFrame = to == .left ? leftFrame : rightFrame;


        nextImage.image = UIImage(named: imagesCollection[nextImageIndex]);
        nextImage.contentMode = .scaleAspectFit
        nextImage.frame = nextStartFrame
        view.addSubview(nextImage)

        UIView.animate(withDuration: 0.2, delay: 0) {
            currentImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0) {
                nextImage.frame = centerFrame
                currentImage.frame.origin.x = prevEndFrame.origin.x

            } completion: { _ in
                self.imageView.removeFromSuperview()
                self.imageView = nextImage
                self.imageViewIndex = nextImageIndex

            }
        }


        // Кейфреймы почему-то обновременно
//        currentImage.transform = CGAffineTransform(scaleX: 1, y: 1)
//        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: .calculationModeLinear, animations: {
//
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.50) {
//                UIView.animate(withDuration: 1.50, animations: {
//                    currentImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//                })
//            }
//            UIView.addKeyframe(withRelativeStartTime: 2.0, relativeDuration: 1.50) {
//                UIView.animate(withDuration: 1.50, animations: {
////                    currentImage.frame = prevEndFrame
////                    currentImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//                    nextImage.frame = centerFrame
////                    currentImage.transform = CGAffineTransform(scaleX: 5, y: 5)
//                }) { _ in
//                    self.imageView.removeFromSuperview()
//                    self.imageView = nextImage
//                    self.imageViewIndex = nextImageIndex
//                }
//            }
//        }, completion: { _ in
////            self.imageView.alpha = 0
//        })

    }
    @objc func viewTapped() {
        //            dismiss(animated: true)
    }

    public func setStartFrame(_ frame: CGRect) {
        startFrame = frame
    }
    public func setImagesCollection(_ images: [String]) {
        imagesCollection = images
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        self.removeFromParent()
        //        self.dismiss(animated: true) {
        //            print("dsafgsdf")
        //        }
        //        self.dismiss(animated:  true) {
        //            print("dismiss")
        //        }
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.completionSpeed = 0.99
        return interactiveTransition
    }



}


extension FullScreenImageViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FullScreenAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FullScreenAnimator()
    }
}

