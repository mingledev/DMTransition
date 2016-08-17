//
//  DMGestureRecognizerTransition.h
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DMGestureRecognizerDirection) {
    DMGestureRecognizerTop,
    DMGestureRecognizerLeft,
    DMGestureRecognizerBottom,
    DMGestureRecognizerRight
};

@interface DMGestureRecognizerTransition : UIPercentDrivenInteractiveTransition

//手势驱动状态
@property (assign, nonatomic, readonly) BOOL interacting;

/**
 *  应当在这个block中告知进行怎样的跳转
 *
 *  @param began 手势开始的回调
 */
- (void)setGestureBeganCallback:(void (^)())began;
- (void)setGestureChangedCallback:(void (^)(CGFloat percent))changed;
- (void)setGestureEndedCallback:(void (^)())ended;
- (void)setGestureCancelledCallback:(void (^)())cancelled;

/**
 *  添加手势到view
 *
 *  @param view 接收手势的视图
 */
- (void)addGestureToView:(UIView *)view direction:(DMGestureRecognizerDirection)direction;

@end
