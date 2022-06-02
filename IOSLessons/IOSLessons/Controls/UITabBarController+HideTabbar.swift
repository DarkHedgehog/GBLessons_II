////
////  UITabBarController+HideTabbar.swift
////  IOSLessons
////
////  Created by Aleksandr Derevenskih on 01.06.2022.
////
//
//import Foundation
//import UIKit
//
//extension UITabBarController {
//    func setHidden(_ hidden: Bool, animated: Bool) {
//        let screenRect = UIScreen.main.bounds
//        var fHeight = screenRect.height
//        if  UIApplication.shared.statusBarOrientation == .landscapeLeft {
//                fHeight = screenRect.size.width;
//            }
//            if (!hidden) {
//                fHeight -= self.tabBar.frame.size.height;
//            }
//            CGFloat animationDuration = animated ? kAnimationDuration : 0.f;
//            [UIView animateWithDuration:animationDuration animations:^{
//                for (UIView *view in self.view.subviews){
//                    if ([view isKindOfClass:[UITabBar class]]) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
//                    }
//                    else {
//                        if (hidden) {
//                            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
//                        }
//                    }
//                }
//            } completion:^(BOOL finished){
//                if (!hidden){
//                    [UIView animateWithDuration:animationDuration animations:^{
//                        for(UIView *view in self.view.subviews) {
//                            if (![view isKindOfClass:[UITabBar class]]) {
//                                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
//                            }
//                        }
//                    }];
//                }
//            }];
//    }
//}
