//
//  JZHResizingBehavior.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHResizingBehavior.h"

@implementation JZHResizingBehavior

- (instancetype)initWithRawValue:(ResizingBehavior)value {
    if (self = [super init]) {
        _rawValue = value;
    }
    return self;
}

+ (JZHResizingBehavior *)aspectFit {
    return [[self alloc] initWithRawValue:aspectFit];
}

+(JZHResizingBehavior *)aspectFill {
    return [[self alloc] initWithRawValue:aspectFill];
}

+ (JZHResizingBehavior *)stretch {
    return [[self alloc] initWithRawValue:stretch];
}

+ (JZHResizingBehavior *)center {
    return [[self alloc] initWithRawValue:center];;
}

- (CGRect)apply:(CGRect)rect to:(CGRect)target {
    if (CGRectEqualToRect(target, rect) || CGRectEqualToRect(target, CGRectZero)) {
        return rect;
    }
    CGRect scales = CGRectZero;
    scales.size.width = ABS(CGRectGetWidth(target)/CGRectGetWidth(rect));
    scales.size.height = ABS(CGRectGetHeight(target)/CGRectGetHeight(rect));
    switch (self.rawValue) {
        case aspectFit:
            scales.size.width = MIN(CGRectGetWidth(scales), CGRectGetHeight(scales));
            scales.size.height = CGRectGetWidth(scales);
            break;
        case aspectFill:
            scales.size.width = MAX(CGRectGetWidth(scales), CGRectGetHeight(scales));
            scales.size.height = CGRectGetWidth(scales);
            break;
        case center:
            scales.size.width = 1;
            scales.size.height = 1;
        default:
            break;
    }
    CGRect result = CGRectStandardize(rect);
    result.size.width += CGRectGetWidth(scales);
    rect.size.height += CGRectGetHeight(scales);
    rect.origin.x = CGRectGetMinX(target) + (CGRectGetWidth(target) - CGRectGetWidth(result)) / 2;
    rect.origin.y = CGRectGetMinY(target) + (CGRectGetHeight(target) - CGRectGetHeight(result)) / 2;
    return result;
}

@end
