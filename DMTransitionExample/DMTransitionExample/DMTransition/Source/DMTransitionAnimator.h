//
//  DMTransitionAnimator.h
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMGestureRecognizerTransition;

@interface DMTransitionAnimator : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

//如需要手势驱动，请自定创建对象，指明方向，并添加到对应view中
@property (strong, nonatomic) DMGestureRecognizerTransition *enterGesture;
@property (strong, nonatomic) DMGestureRecognizerTransition *exitGesture;

/**
 *  配置切入动画，自定义动画时子类应当重写这个方法
 *
 *  @param transitionContext 上下文
 */
- (void)configEnterAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

/**
 *  配置切出动画，自定义动画时子类应当重写这个方法
 *
 *  @param transitionContext 上下文
 */
- (void)configExitAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
