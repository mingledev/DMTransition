//
//  DMGestureRecognizerTransition.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "DMGestureRecognizerTransition.h"

typedef void(^BlockWithNP)();
typedef void(^BlockWithOP)(CGFloat);

@interface DMGestureRecognizerTransition ()

@property (copy, nonatomic) BlockWithNP beganBlock;
@property (copy, nonatomic) BlockWithNP cancelledBlock;
@property (copy, nonatomic) BlockWithNP endedBlock;
@property (copy, nonatomic) BlockWithOP changedBlock;

//手势方向
@property (assign, nonatomic) DMGestureRecognizerDirection direction;

@property (assign, nonatomic) CGFloat velocity;

@property (nonatomic, assign) BOOL shouldComplete;

@end

@implementation DMGestureRecognizerTransition

- (instancetype)init {
    if (self = [super init]) {
        _velocity = 600;
    }
    return self;
}

- (void)setGestureBeganCallback:(void (^)())began {
    self.beganBlock = began;
}

- (void)setGestureEndedCallback:(void (^)())ended {
    self.endedBlock = ended;
}

- (void)setGestureChangedCallback:(void (^)(CGFloat))changed {
    self.changedBlock = changed;
}

- (void)setGestureCancelledCallback:(void (^)())cancelled {
    self.cancelledBlock = cancelled;
}

- (void)addGestureToView:(UIView *)view direction:(DMGestureRecognizerDirection)direction {
    self.direction = direction;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [view addGestureRecognizer:panGesture];

}

- (void)handlePanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _interacting = YES;
            if (self.beganBlock)
                self.beganBlock();
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction;
            switch (self.direction) {
                case DMGestureRecognizerTop:
                    fraction = -(translation.y / [UIScreen mainScreen].bounds.size.height);
                    break;
                case DMGestureRecognizerLeft:
                    fraction = -(translation.x / [UIScreen mainScreen].bounds.size.width);
                    break;
                case DMGestureRecognizerBottom:
                    fraction = (translation.y / [UIScreen mainScreen].bounds.size.height);
                    break;
                case DMGestureRecognizerRight:
                    fraction = (translation.x / [UIScreen mainScreen].bounds.size.width);
                    break;
                default:
                    break;
            }
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);
            [self updateInteractiveTransition:fraction];
            if (self.changedBlock)
                self.changedBlock(fraction);
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            CGPoint pt = [sender velocityInView:sender.view];
            if (!self.shouldComplete)
                switch (self.direction) {
                    case DMGestureRecognizerTop:
                        -pt.y > self.velocity ? (self.shouldComplete = YES) : (self.shouldComplete = NO);
                        break;
                    case DMGestureRecognizerLeft:
                        -pt.x > self.velocity ? (self.shouldComplete = YES) : (self.shouldComplete = NO);
                        break;
                    case DMGestureRecognizerBottom:
                        pt.y > self.velocity ? (self.shouldComplete = YES) : (self.shouldComplete = NO);
                        break;
                    case DMGestureRecognizerRight:
                        pt.x > self.velocity ? (self.shouldComplete = YES) : (self.shouldComplete = NO);
                        break;
                    default:
                        break;
                }
            _interacting = NO;
            if (!self.shouldComplete || sender.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
                if (self.cancelledBlock)
                    self.cancelledBlock();
            } else {
                [self finishInteractiveTransition];
                if (self.endedBlock)
                    self.endedBlock();
            }
        }
            break;
        default:
            break;
    }
}

@end
