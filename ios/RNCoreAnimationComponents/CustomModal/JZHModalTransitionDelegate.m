//
//  JZHModalTransitionDelegate.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHModalTransitionDelegate.h"
#import "JZHStarWarsGLAnimator.h"
#import "JZHUIDynamicAnimator.h"

static NSMapTable<UIView*, JZHModalTransitionDelegate*>* table;

@implementation JZHModalTransitionDelegate

+ (void)load {
    table = [NSMapTable weakToStrongObjectsMapTable];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[JZHUIDynamicAnimator alloc] init];
}

+ (instancetype)modalDelegateForTag:(__kindof UIView *)view {
    return [table objectForKey:view];
}

+ (instancetype)addModalDelegaetForTag:(__kindof UIView *)view {
    JZHModalTransitionDelegate* delegate = [JZHModalTransitionDelegate new];
    [table setObject:delegate forKey:view];
    return delegate;
}

@end
