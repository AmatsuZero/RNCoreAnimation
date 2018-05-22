//
//  JZHProfileButton.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/22.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHProfileButton.h"
#import "CircularRevealAnimator.h"

const CGFloat ButtonPadding = 50;

@interface AnimationDelegate: NSObject<CAAnimationDelegate>

@property(nonatomic, copy) void (^completion)(void);

@end

@implementation AnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.completion();
}

@end

@implementation JZHProfileButton

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width + ButtonPadding, size.height);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)animation {
    self.userInteractionEnabled = NO;
    self.layer.masksToBounds = YES;

    CALayer *fillLayer = [CALayer layer];
    fillLayer.backgroundColor = self.layer.borderColor;
    fillLayer.frame = self.layer.bounds;
    [fillLayer insertSublayer:fillLayer atIndex:0];

    CGPoint center = CGPointMake(CGRectGetMidX(fillLayer.bounds), CGRectGetMidY(fillLayer.bounds));
    CGFloat radius = MAX(self.frame.size.width/2, self.frame.size.height/2);

    CircularRevealAnimator* circularAnimation = [[CircularRevealAnimator alloc] initWithLayer:fillLayer
                                                                                       center:center
                                                                                  startRadius:0
                                                                                    endRadius:radius
                                                                                       invert:NO];
    circularAnimation.duration = 0.2;
    __weak typeof(self) weakSelf = self;
    circularAnimation.completion = ^{
        fillLayer.opacity = 0;
        CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @1.f;
        opacityAnimation.toValue = @0;
        opacityAnimation.duration = 0.2;
        AnimationDelegate *delegate = [AnimationDelegate new];
        delegate.completion = ^{
            [fillLayer removeFromSuperlayer];
            [weakSelf setUserInteractionEnabled:YES];
            if ([weakSelf clickEvent]) {
                weakSelf.clickEvent(nil);
            }
        };
        opacityAnimation.delegate = delegate;
        [fillLayer addAnimation:opacityAnimation forKey:@"opacity"];
    };
    [circularAnimation start];
}


@end
