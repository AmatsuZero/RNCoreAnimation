//
//  JZHIDynamicAnimator.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/24.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHUIDynamicAnimator.h"
#import <React/RCTLog.h>

@implementation JZHUIDynamicAnimator {
    id<UIViewControllerContextTransitioning> _Nullable context;
    UIDynamicAnimator* animator;
}

- (instancetype)init {
    if (self = [super init]) {
        _duration = 2;
        _spriteWidth = 20;
    }
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView* containerView = [transitionContext containerView];
    UIView* fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];

    CGSize size = fromView.frame.size;
    float(^randomFloatBetween)(CGFloat, CGFloat) = ^(CGFloat small, CGFloat big) {
        return fmodf((CGFloat)(arc4random()/100.f), big -small) + (float)small;
    };
    // snapshot the from view, this makes subsequent snaphots more performant
    UIView* fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    CGFloat width = _spriteWidth;
    CGFloat height = width;

    animator = [[UIDynamicAnimator alloc] initWithReferenceView:containerView];
    NSMutableArray<UIView*>* snapshots = [NSMutableArray array];
    for (CGFloat x = 0; x < size.width; x += width) {
        for (CGFloat y = 0; y < size.height; y += height) {
            @autoreleasepool {
                CGRect snapshotsRegion = CGRectMake(x, y, width, height);
                UIView* snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotsRegion
                                                                afterScreenUpdates:NO
                                                                     withCapInsets:UIEdgeInsetsZero];
                [containerView addSubview:snapshot];
                snapshot.frame = snapshotsRegion;
                [snapshots addObject:snapshot];

                UIPushBehavior* push = [[UIPushBehavior alloc] initWithItems:@[snapshot] mode:UIPushBehaviorModeInstantaneous];
                push.pushDirection = CGVectorMake(randomFloatBetween(-0.15, 0.15), randomFloatBetween(-0.15, 0));
                push.active = YES;
                [animator addBehavior:push];
            }
        }
    }
    UIGravityBehavior* gravity = [[UIGravityBehavior alloc] initWithItems:snapshots];
    [animator addBehavior:gravity];
    RCTLog(@"Snapshots Count: %li", snapshots.count);
    [fromView removeFromSuperview];
    [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(completeTransition) userInfo:nil repeats:NO];
    context = transitionContext;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)completeTransition {
    [context completeTransition:!context.transitionWasCancelled];
}

@end
