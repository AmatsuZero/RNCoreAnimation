//
//  JZHLiquidLineEffect.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHLiquidLineEffect.h"
#import "JZHCGValueManipulation.h"
#import "NSArray+JZHLoadash.h"
#import "JZHLiquidLoader.h"

@implementation JZHLiquidLineEffect

- (NSArray<JZHLiquittableCircle *> *)setupShape {
    NSMutableArray<JZHLiquittableCircle *>* result = [NSMutableArray arrayWithCapacity:self.numberOfCircles];
    for (NSUInteger i = 0; i < self.numberOfCircles; i++) {
        JZHLiquittableCircle* circle = [[JZHLiquittableCircle alloc] initWithCenter:CGPointMake(self.circleInter+self.circleRadius+i*(self.circleInter+2*self.circleRadius), self.loader.frame.size.height*0.5) radius:self.circleRadius color:self.color growColor:self.growColor];
        [result addObject:circle];
    }
    return result;
}

- (CGPoint)move:(CGFloat)position {
    if (!self.loader) {
        return CGPointZero;
    }
    return CGPointMake(CGRectGetRightBottom(self.circles.lastObject.frame).x*[self sinTransform:position],
                       self.loader.frame.size.height*0.5);
}

- (CGFloat)sinTransform:(CGFloat)key {
    return sin(key*M_PI)*0.5+0.5;
}

- (void)update {
    if (self.key >= 0 && self.key <= 2.0) {
        self.key += 2/(self.duration*60);
    } else {
        self.key -= 1.0;
    }
}

- (void)willSetup {
    if (self.circleRadius == 0) {
        self.circleRadius = CGRectGetWidth(self.loader.frame)*0.05;
    }
    self.circleInter = (CGRectGetWidth(self.loader.frame)-2*self.circleRadius*5)/6;
    self.engine = [[JZHSimpleCircleLiquidEngine alloc] initWithRaiusThresh:self.circleRadius angleTresh:.2];
    self.circleRadius = CGRectGetWidth(self.loader.frame) * 0.09;
    self.moveCircle = [[JZHLiquittableCircle alloc] initWithCenter:CGPointMake(0, CGRectGetHeight(self.loader.frame)*0.5)
                                                            radius:self.circleRadius*self.moveScale
                                                             color:self.color
                                                         growColor:self.growColor];
}

- (void)resize {
    if (!self.loader || !self.moveCircle) {
        return;
    }
    for (NSDictionary* pair in [self.circles map:^id(JZHLiquittableCircle * circle) {
        return @{@"circle": circle, @"distance": @(CGPointGetLength(CGPointMinus(circle.center, self.moveCircle.center)))};
    }]) {
        CGFloat distance = [pair[@"distance"] floatValue];
        CGFloat normalized = 1-distance/(self.circleRadius+self.circleInter);
        JZHLiquittableCircle* circle = pair[@"circle"];
        if (normalized > 0) {
            circle.radius = self.circleRadius + (self.circleRadius*self.circleScale-self.circleRadius)*normalized;
        } else {
            circle.radius = self.circleRadius;
        }
    }
}

@end
