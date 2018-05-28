//
//  JZHUViewAnimator.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/28.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHUViewAnimator.h"

@implementation JZHUViewAnimator

- (instancetype)init {
    if (self = [super init]) {
        _duration = 2;
        _spriteWidth = 10;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)startInteractiveTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView* containerView = [transitionContext containerView];
    UIView* fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];

    NSMutableArray<UIView*>* snapshots = [NSMutableArray array];
    CGSize size = fromView.frame.size;
    float(^randomFloatBetween)(CGFloat, CGFloat) = ^(CGFloat small, CGFloat big) {
        return fmodf((CGFloat)(arc4random()/100.f), big -small) + (float)small;
    };

    // snapshot the from view, this makes subsequent snaphots more performant
    UIView* fromViewSnapShot = [fromView snapshotViewAfterScreenUpdates:NO];

    CGFloat width = self.spriteWidth;
    CGFloat height = width;

    for (CGFloat x = 0; x < size.width; x += width) {
        for (CGFloat y = 0; y < size.height; y += height) {
            CGRect snapshotsRegion = CGRectMake(x, y, width, height);
            UIView* snapshot = [fromViewSnapShot resizableSnapshotViewFromRect:snapshotsRegion afterScreenUpdates:false withCapInsets:UIEdgeInsetsZero];
            [containerView addSubview:snapshot];
            snapshot.frame = snapshotsRegion;
            [snapshots addObject:snapshot];
        }
    }

    [containerView sendSubviewToBack:fromView];
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [snapshots enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat xOffset = randomFloatBetween(-200, 200);
            CGFloat yOffset = randomFloatBetween(fromView.frame.size.height, fromView.frame.size.height * 1.3);
            view.frame = CGRectOffset(view.frame, xOffset, yOffset);
        }];
    } completion:^(BOOL finished) {
        [snapshots enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            [view removeFromSuperview];
        }];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end


