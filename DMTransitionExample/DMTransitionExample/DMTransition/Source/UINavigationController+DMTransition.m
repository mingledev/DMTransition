//
//  UINavigationController+DMTransition.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "UINavigationController+DMTransition.h"
#import "UIViewController+DMTransition.h"
#import <objc/runtime.h>

@implementation UINavigationController (DMTransition)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pushViewController:animated:)), class_getInstanceMethod(self, @selector(dm_pushViewController:animated:)));
}

- (void)dm_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.transitionAnimator) {
        viewController.transitioningDelegate = self.transitionAnimator;
        self.delegate = (id<UINavigationControllerDelegate>)self.transitionAnimator;
    }
    [self dm_pushViewController:viewController animated:animated];
}

@end
