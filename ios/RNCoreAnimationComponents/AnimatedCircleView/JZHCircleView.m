//
//  JZHCircleView.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHCircleView.h"
#import "JZHCircleLayer.h"

@implementation JZHCircleView
{
    JZHCircleLayer* _circleLayer;
    NSNumber* firstDisplayValue;
}

+(Class)layerClass {
    return [JZHCircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _circleLayer = [JZHCircleLayer layer];
        _circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer: _circleLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _circleLayer.frame = self.bounds;
    if (firstDisplayValue) {
        [self setProgress:[firstDisplayValue doubleValue]];
        firstDisplayValue = nil;
    }
}

- (void)setProgress:(CGFloat)progress {
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        firstDisplayValue = @(progress);
        return;
    }
    _circleLayer.progress = progress;
}

- (CGFloat)progress {
    return _circleLayer.progress;
}

@end
