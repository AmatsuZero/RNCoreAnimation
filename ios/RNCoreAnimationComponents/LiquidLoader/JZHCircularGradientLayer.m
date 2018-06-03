//
//  JZHCircularGradientLayer.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHCircularGradientLayer.h"
#import "UIBezierPath+JZHBezierPathHelper.h"
#import "NSArray+JZHLoadash.h"
#import "JZHCGValueManipulation.h"

@implementation JZHCircularGradientLayer

- (instancetype)initWithColors:(NSArray<UIColor *> *)colors {
    if (self = [super init]) {
        _colors = colors;
        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    NSArray<NSNumber*>* locations =  CGMathLineSpace(0, 1, self.colors.count);
    locations = [[[locations map:^id(NSNumber * value) {
        CGFloat v = [value floatValue];
        return @(1- v*v);
    }] reverseObjectEnumerator] allObjects];
    CGFloat* locs = calloc(locations.count, sizeof(CGFloat));
    [locations enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        locs[idx] = [obj floatValue];
    }];
    CGGradientRef gradients = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), (__bridge CFArrayRef)self.colors, locs);
    CGContextDrawRadialGradient(ctx, gradients, CGRectGetCenter(self.frame), 0, CGRectGetCenter(self.frame), MAX(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    free(locs);
}

@end
