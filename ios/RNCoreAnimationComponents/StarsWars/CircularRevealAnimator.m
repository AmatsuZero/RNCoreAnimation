//
//  CircularRevealAnimator.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/22.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "CircularRevealAnimator.h"
#import <React/RCTAssert.h>

CGRect SquareAroundCircle(CGPoint center, CGFloat radius) {
    RCTAssert(0 <= radius, @"radius must be a positive value");
    return CGRectInset(CGRectMake(center.x, center.y, 0, 0), -radius, -radius);
}

@interface CircularRevealAnimator()<CAAnimationDelegate>
{
    CALayer* layer;
    CAShapeLayer* mask;
    CABasicAnimation* animation;
}
@end

@implementation CircularRevealAnimator

@synthesize timingFunction = _timingFunction;
@synthesize duration = _duration;

- (CAMediaTimingFunction *)timingFunction {
    return animation.timingFunction;
}

- (void)setTimingFunction:(CAMediaTimingFunction *)timingFunction {
    animation.timingFunction = timingFunction;
}

- (CFTimeInterval)duration {
    return animation.duration;
}

- (void)setDuration:(CFTimeInterval)duration {
    animation.duration = duration;
}

- (instancetype)initWithLayer:(CALayer *)layer
                       center:(CGPoint)center
                  startRadius:(CGFloat)startRadius
                    endRadius:(CGFloat)endRadius
                       invert:(BOOL)isInvert {
    if (self = [super init]) {
        CGPathRef starCirclePath = CGPathCreateWithEllipseInRect(SquareAroundCircle(center, startRadius), NULL);
        CGPathRef endCirclePath = CGPathCreateWithEllipseInRect(SquareAroundCircle(center, endRadius), NULL);
        CGMutablePathRef startPath = CGPathCreateMutableCopy(starCirclePath);
        CGMutablePathRef endPath = CGPathCreateMutableCopy(endCirclePath);
        if (isInvert) {
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, layer.bounds);
            CGPathAddPath(path, NULL, starCirclePath);
            startPath = path;
            path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, layer.bounds);
            CGPathAddPath(path, NULL, endCirclePath);
            endPath = path;
        }
        self->layer = layer;

        mask = [CAShapeLayer layer];
        mask.path = endPath;
        mask.fillRule = kCAFillRuleEvenOdd;

        animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id _Nullable)(startPath);
        animation.toValue = (__bridge id _Nullable)(endPath);
        animation.delegate = self;
    }
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    layer.mask = nil;
    if (self.completion) {
        self.completion();
    }
}

- (void)start {
    layer.mask = mask;
    mask.frame = layer.bounds;
    [mask addAnimation:animation forKey:@"reveal"];
}

@end
