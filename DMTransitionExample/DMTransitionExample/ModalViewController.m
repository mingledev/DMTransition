//
//  ModalViewController.m
//  DMTransitionExample
//
//  Created by iMac on 16/8/16.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController

- (IBAction)dismissOnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
