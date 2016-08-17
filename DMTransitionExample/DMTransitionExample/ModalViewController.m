//
//  ModalViewController.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (IBAction)dismissOnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
