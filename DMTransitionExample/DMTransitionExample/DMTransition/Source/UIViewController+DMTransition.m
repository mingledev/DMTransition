//
//  UIViewController+DMTransition.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "UIViewController+DMTransition.h"
#import <objc/runtime.h>

const char *DMTransitionAnimatorKey = "DMTransitionAnimatorKey";

@implementation UIViewController (DMTransition)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:)), class_getInstanceMethod([self class], @selector(dm_presentViewController:animated:completion:)));
}

- (void)setTransitionAnimator:(DMTransitionAnimator *)animator {
    objc_setAssociatedObject(self, DMTransitionAnimatorKey, animator, OBJC_ASSOCIATION_RETAIN);
}

- (DMTransitionAnimator *)transitionAnimator {
    return objc_getAssociatedObject(self, DMTransitionAnimatorKey);
}

- (void)dm_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (viewControllerToPresent.transitionAnimator)
        viewControllerToPresent.transitioningDelegate = viewControllerToPresent.transitionAnimator;
    [self dm_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
