//
//  ViewController.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "DMTransition.h"
#import "DMPushBounceAnimator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ModalViewController"];
    vc.transitionAnimator = [DMPushBounceAnimator new];
    DMGestureRecognizerTransition *enterGestureTransition = [DMGestureRecognizerTransition new];
    [enterGestureTransition addGestureToView:self.view direction:DMGestureRecognizerLeft];
    [enterGestureTransition setGestureBeganCallback:^{
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }];
    DMGestureRecognizerTransition *exitGestureTransition = [DMGestureRecognizerTransition new];
    [exitGestureTransition addGestureToView:vc.view direction:DMGestureRecognizerRight];
    [exitGestureTransition setGestureBeganCallback:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    vc.transitionAnimator.exitGesture = exitGestureTransition;
    vc.transitionAnimator.enterGesture = enterGestureTransition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentOnClick:(id)sender {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ModalViewController"];
    vc.transitionAnimator = [DMPushBounceAnimator new];
    DMGestureRecognizerTransition *exitGestureTransition = [DMGestureRecognizerTransition new];
    [exitGestureTransition addGestureToView:vc.view direction:DMGestureRecognizerRight];
    [exitGestureTransition setGestureBeganCallback:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    vc.transitionAnimator.exitGesture = exitGestureTransition;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)pushOnClick:(id)sender {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ModalViewController"];
    self.navigationController.transitionAnimator = [DMPushBounceAnimator new];
    DMGestureRecognizerTransition *exitGestureTransition = [DMGestureRecognizerTransition new];
    [exitGestureTransition addGestureToView:self.navigationController.view direction:DMGestureRecognizerRight];
    [exitGestureTransition setGestureBeganCallback:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationController.transitionAnimator.exitGesture = exitGestureTransition;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
