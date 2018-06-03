//
//  JZHLiquittableCircle.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHLiquittableCircle.h"
#import "UIView+JZHGrow.h"
#import "UIBezierPath+JZHBezierPathHelper.h"
#import "JZHCGValueManipulation.h"

@implementation JZHLiquittableCircle

- (instancetype)initWithCenter:(CGPoint)center
                        radius:(CGFloat)radius
                         color:(UIColor *)color
                     growColor:(UIColor *)gColor {
    CGRect frame = CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius);
    if (self = [super initWithFrame:frame]) {
        _radius = radius;
        _color = color;
        _color = color;
        if (gColor) {
            _growColor = gColor;
        }
        [self setup];
    }
    return self;
}

- (void)move:(CGPoint)dt {
    self.center = CGPointPlus(self.center, dt);
}

- (void)draw:(UIBezierPath *)path {
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    CAShapeLayer* layer = [[CAShapeLayer alloc] initWithLayer:self.layer];
    layer.lineWidth = 3.f;
    layer.fillColor = self.color.CGColor;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    if (self.isGrow) {
        [self grow:YES];
    }
}

- (void)grow:(BOOL)isGrow {
    if (isGrow) {
        [self growShadowWithColor:self.growColor radius:self.radius shininess:1.6];
    } else {
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0;
    }
}

- (void)setup {
    self.frame = CGRectMake(self.center.x - self.radius, self.center.y - self.radius, 2 * self.radius, 2 * self.radius);
    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.radius * 2, self.radius * 2)];
    [self draw:path];
}

- (CGPoint)circlePoint:(CGFloat)rad {
    return CGMathCirclePoint(self.center, self.radius, rad);
}

@end
