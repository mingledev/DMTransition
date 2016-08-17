//
//  DMPushBounceAnimator.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/17.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "DMPushBounceAnimator.h"

@implementation DMPushBounceAnimator

- (void)configEnterAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, [UIScreen mainScreen].bounds.size.width, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)configExitAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = CGRectOffset([transitionContext initialFrameForViewController:fromVC], [UIScreen mainScreen].bounds.size.width, 0);
    
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] sendSubviewToBack:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
