//
//  JZHLiquidCircleEffect.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHLiquidCircleEffect.h"
#import "JZHCGValueManipulation.h"
#import "NSArray+JZHLoadash.h"
#import "JZHLiquidLoader.h"

@implementation JZHLiquidCircleEffect

- (CGFloat)radius {
    return CGRectGetWidth(self.loader.frame) * 0.5;
}

- (NSArray<JZHLiquittableCircle *> *)setupShape {
    NSMutableArray<JZHLiquittableCircle *>* result = [NSMutableArray arrayWithCapacity:self.numberOfCircles];
    for (NSUInteger i = 0; i < self.numberOfCircles; i++) {
        CGFloat angle = i * (M_PI * 2) / 8.0;
        CGRect frame = self.loader.frame;
        CGPoint center = CGMathCirclePoint(CGPointMinus(self.loader.center, frame.origin), self.radius-self.circleRadius, angle);
        JZHLiquittableCircle* circle = [[JZHLiquittableCircle alloc] initWithCenter:center radius:self.circleRadius color:self.color growColor:self.growColor];
        [result addObject:circle];
    }
    return result;
}

- (CGPoint)move:(CGFloat)position {
    if (!self.loader) {
        return CGPointZero;
    }
    CGPoint frame = CGPointMinus(self.loader.center, self.loader.frame.origin);
    return CGMathCirclePoint(frame, self.radius-self.circleRadius, self.key*2*M_PI);
}

- (void)update {
    if (self.key >= 0 && self.key <= 1) {
        self.key += 1/(self.duration*60);
    } else {
        self.key -= 1.0;
    }
}

- (void)willSetup {
    self.circleRadius = CGRectGetWidth(self.loader.frame) * 0.09;
    self.circleScale = 1.10;
    self.engine = [[JZHSimpleCircleLiquidEngine alloc] initWithRaiusThresh:self.circleRadius*0.85 angleTresh:.5];
    self.moveCircle = [[JZHLiquittableCircle alloc] initWithCenter:[self move:0]
                                                            radius:self.circleRadius*self.moveScale
                                                             color:self.color
                                                         growColor:self.growColor];
}

- (void)resize {
    if (!self.loader || !self.moveCircle) {
        return;
    }
    CGPoint moveVec = CGPointMinus(self.moveCircle.center, CGPointNomalized(CGPointMinus(self.loader.center, self.loader.frame.origin)));
    for (NSDictionary* pair in [self.circles map:^id(JZHLiquittableCircle * circle) {
        return @{@"circle": circle, @"dot": @(CGPointDot(moveVec, CGPointNomalized(CGPointMinus(circle.center, CGPointMinus(self.loader.center, self.loader.frame.origin)))))};
    }]) {
        CGFloat dot = [pair[@"dot"] floatValue];
        JZHLiquittableCircle* circle = pair[@"circle"];
        if (dot > 0.75 && dot <= 1.0) {
            CGFloat normalized = (dot - 0.75) / 0.25;
            CGFloat scale = normalized * normalized;
            circle.radius = self.circleRadius + (self.circleRadius*self.circleScale-self.circleRadius)*scale;
        } else {
            circle.radius = self.circleRadius;
        }
    }
}

@end
