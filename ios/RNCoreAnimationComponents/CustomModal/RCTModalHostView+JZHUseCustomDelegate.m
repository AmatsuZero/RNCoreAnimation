//
//  RCTModalHostView+JZHUseCustomDelegate.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import "RCTModalHostView+JZHUseCustomDelegate.h"
#import "JZHModalTransitionDelegate.h"

@implementation RCTModalHostView (JZHUseCustomDelegate)

- (void)setUseCustomDelegate:(BOOL)useCustomDelegate {
    if (useCustomDelegate) {
        JZHModalTransitionDelegate* delegate = [JZHModalTransitionDelegate addModalDelegaetForTag:self.identifier];
        UIViewController* controller = [self valueForKeyPath:@"modalViewController"];
        controller.transitioningDelegate = delegate;
    }
}

- (BOOL)useCustomDelegate {
    return [JZHModalTransitionDelegate modalDelegateForTag:self.identifier] != nil;
}

@end
