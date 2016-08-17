//
//  DMTransitionAnimator.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "DMTransitionAnimator.h"
#import "DMGestureRecognizerTransition.h"

typedef NS_ENUM(NSUInteger, DMTransitionType) {
    DMTransitionEnter,
    DMTransitionExit
};

@interface DMTransitionAnimator ()

@property (assign, nonatomic) DMTransitionType transitionType;
@property (assign, nonatomic) UINavigationControllerOperation operation;

@end

@implementation DMTransitionAnimator

- (instancetype)init {
    if (self = [super init]) {
        _transitionEnterDuration = 0.8f;
        _transitionExitDuration = 0.4f;
        
    }
    return self;
}

- (void)configEnterAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //子类根据上下文得到from、to、container在此处实现想要的动画效果
    //...
    
}

- (void)configExitAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //子类根据上下文得到from、to、container在此处实现想要的动画效果
    //...
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.transitionType == DMTransitionExit)
        return self.transitionExitDuration;
    return self.transitionEnterDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitionType) {
        case DMTransitionEnter:
            [self configEnterAnimation:transitionContext];
            break;
        case DMTransitionExit:
            [self configExitAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.transitionType = DMTransitionEnter;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transitionType = DMTransitionExit;
    return self;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.enterGesture.interacting ? self.enterGesture : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.exitGesture.interacting ? self.exitGesture : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return self.operation == UINavigationControllerOperationPush ? (self.enterGesture.interacting ? self.enterGesture : nil) : (self.exitGesture.interacting ? self.exitGesture : nil);
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    self.operation = operation;
    switch (operation) {
        case UINavigationControllerOperationPop:
            self.transitionType = DMTransitionExit;
            break;
        case UINavigationControllerOperationPush:
            self.transitionType = DMTransitionEnter;
            break;
        default:
            return nil;
            break;
    }
    return self;
}

@end
