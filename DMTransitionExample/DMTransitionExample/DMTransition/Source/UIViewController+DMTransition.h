//
//  UIViewController+DMTransition.h
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMTransitionAnimator;
@class DMGestureRecognizerTransition;

@interface UIViewController (DMTransition)

//转场动画
@property DMTransitionAnimator<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate> *transitionAnimator;

@end
