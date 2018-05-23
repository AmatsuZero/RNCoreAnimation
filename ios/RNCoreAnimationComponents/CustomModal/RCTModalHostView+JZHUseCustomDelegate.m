//
//  RCTModalHostView+JZHUseCustomDelegate.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import "RCTModalHostView+JZHUseCustomDelegate.h"
#import "JZHModalTransitionDelegate.h"
#import <React/RCTUtils.h>

@implementation RCTModalHostView (JZHUseCustomDelegate)

+(void)load {
    RCTSwapInstanceMethods(self, @selector(setAnimationType:), @selector(jzh_setAnimationType:));
}

- (void)jzh_setAnimationType:(NSString*)style {
    [self jzh_setAnimationType:style];
}

@end
