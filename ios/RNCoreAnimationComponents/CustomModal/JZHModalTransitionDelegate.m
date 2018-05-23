//
//  JZHModalTransitionDelegate.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHModalTransitionDelegate.h"
#import "JZHStarWarsGLAnimator.h"

static NSMapTable<NSNumber*, JZHModalTransitionDelegate*>* table;

@implementation JZHModalTransitionDelegate

+ (void)load {
    table = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[JZHStarWarsGLAnimator alloc] init];
}

+ (instancetype)modalDelegateForTag:(NSNumber *)tag {
    return [table objectForKey:tag];
}

+ (instancetype)addModalDelegaetForTag:(NSNumber *)tag {
    JZHModalTransitionDelegate* delegate = [JZHModalTransitionDelegate new];
    [table setObject:delegate forKey:tag];
    return delegate;
}

@end
