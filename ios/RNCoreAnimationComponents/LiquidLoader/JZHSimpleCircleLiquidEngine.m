//
//  JZHSimpleCircleLiquidEngine.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHSimpleCircleLiquidEngine.h"
#import "JZHCGValueManipulation.h"
#import "UIBezierPath+JZHBezierPathHelper.h"
#import "NSArray+JZHLoadash.h"

@implementation JZHSimpleCircleLiquidEngine {
    CAShapeLayer* layer;
}

- (instancetype)initWithRaiusThresh:(CGFloat)radius angleTresh:(CGFloat)angle {
    if (self = [super init]) {
        layer = [CAShapeLayer layer];
        _radiusTresh = radius;
        _angleThresh = angle;
        _connectTresh = 0.3;
        _color = [UIColor new];
    }
    return self;
}

- (instancetype)init {
    return [self initWithRaiusThresh:0 angleTresh:0.5];
}

- (void)draw:(UIView *)parent {
    [parent.layer addSublayer: layer];
}

- (NSArray<JZHLiquittableCircle*>*)push:(JZHLiquittableCircle *)circle
                                  other:(JZHLiquittableCircle *)other {
    NSArray<UIBezierPath*>* paths = [self generateConnectedPath:circle other:other];
    if (paths) {
        NSArray<CALayer*>* layers = [paths map:^id(UIBezierPath * path) {
            return [self construct:path];
        }];
        [layers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self->layer addSublayer:obj];
        }];
        return @[circle, other];
    }
    return @[];
}

- (CALayer *)construct:(UIBezierPath *)path {
    CGRect pathBounds = CGPathGetBoundingBox(path.CGPath);
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.fillColor = self.color.CGColor;
    shape.path = path.CGPath;
    shape.frame = CGRectMake(0, 0, CGRectGetWidth(pathBounds), CGRectGetHeight(pathBounds));
    return shape;
}

- (void)clear {
    [layer removeFromSuperlayer];
    [layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    layer = [CAShapeLayer layer];
}

- (NSArray<NSValue*>*)circleConnnectPoint:(JZHLiquittableCircle*)circle
                                    other:(JZHLiquittableCircle*)other
                                    angle:(CGFloat)angle {
    CGPoint vec = CGPointMinus(other.center, circle.center);
    CGFloat radian = atan2(vec.y, vec.x);
    CGPoint p1 = [circle circlePoint:radian+angle];
    CGPoint p2 = [circle circlePoint:radian-angle];
    return @[[NSValue valueWithCGPoint:p1], [NSValue valueWithCGPoint:p2]];
}

- (NSArray<NSValue*>*)circleConnnectPoint:(JZHLiquittableCircle*)circle
                                    other:(JZHLiquittableCircle*)other {
    CGFloat ratio = [self circleRatio:circle other:other];
    ratio = (ratio + self.connectTresh) / (1.0 + self.connectTresh);
    CGFloat angle = M_PI / 2 * ratio;
    return [self circleConnnectPoint:circle other:other angle:angle];
}

- (NSArray<UIBezierPath*>* _Nullable)generateConnectedPath:(JZHLiquittableCircle*)circle other:(JZHLiquittableCircle*)other {
    CGFloat ratio = [self circleRatio:circle other:other];
    if (![self isConnected:circle other:other]) {
        return nil;
    }
    if (ratio >= self.angleThresh && ratio <= 1) {
        UIBezierPath* path = [self normalPath:circle other:other];
        if (path) {
            return @[path];
        }
        return  nil;
    } else if (ratio >= 0 && ratio < self.angleThresh) {
        return [self splitPath:circle other:other ratio: ratio];
    } else {
        return nil;
    }
}

- (UIBezierPath* _Nullable)normalPath:(JZHLiquittableCircle*)circle other:(JZHLiquittableCircle*)other {
    NSArray<NSValue*>* val1 = [self circleConnnectPoint:circle other:other];
    NSArray<NSValue*>* val2 = [self circleConnnectPoint:other other:circle];
    CGPoint p1 = [val1[0] CGPointValue];
    CGPoint p2 = [val1[1] CGPointValue];
    CGPoint p3 = [val2[0] CGPointValue];
    CGPoint p4 = [val2[1] CGPointValue];
    
    CGPoint crossed =  CGPointIntersection(p1, p3, p2, p4);
    if (CGPointEqualToPoint(crossed, CGPointZero)) {
        return nil;
    }
    return [UIBezierPath with:^(UIBezierPath * path) {
        CGFloat ratio = [self circleRatio:circle other:other];
        [path moveToPoint:p1];
        CGPoint mul = CGPointSplit(CGPointDivide(CGPointPlus(p1, p4), 2), crossed, ratio*1.25-0.25);
        [path addQuadCurveToPoint:p4 controlPoint:mul];
        [path addLineToPoint:p3];
        CGPoint mul2 = CGPointSplit(CGPointDivide(CGPointPlus(p2, p3), 2), crossed, ratio*1.25-0.25);
        [path addQuadCurveToPoint:p2 controlPoint:mul2];
    }];
}

- (NSArray<UIBezierPath*>*)splitPath:(JZHLiquittableCircle*)circle
                                         other:(JZHLiquittableCircle*)other
                                         ratio:(CGFloat)ratio {
    NSArray<NSValue*>* val1 = [self circleConnnectPoint:circle other:other angle:CGMathDegToRad(40)];
    NSArray<NSValue*>* val2 = [self circleConnnectPoint:other other:circle angle:CGMathDegToRad(40)];
    CGPoint p1 = [val1[0] CGPointValue];
    CGPoint p2 = [val1[1] CGPointValue];
    CGPoint p3 = [val2[0] CGPointValue];
    CGPoint p4 = [val2[1] CGPointValue];
    CGPoint crossed =  CGPointIntersection(p1, p3, p2, p4);
    if (CGPointEqualToPoint(crossed, CGPointZero)) {
        return @[];
    }
    val1 = [self circleConnnectPoint:circle other:other angle:0];
    val2 = [self circleConnnectPoint:other other:circle angle:0];
    CGPoint d1 = [val1[0] CGPointValue];
    CGPoint d2 = [val2[0] CGPointValue];
    CGFloat r = (ratio - self.connectTresh)/(self.angleThresh-self.connectTresh);
    CGPoint a1 = CGPointSplit(d1, CGPointMid(crossed, d2), 1-r);
    UIBezierPath* part = [UIBezierPath with:^(UIBezierPath * path) {
        [path moveToPoint:p1];
        [path addQuadCurveToPoint:p2 controlPoint:a1];
    }];
    CGPoint a2 = CGPointSplit(d2, CGPointMid(crossed, d1), 1-r);
    UIBezierPath* part2 = [UIBezierPath with:^(UIBezierPath * path) {
        [path moveToPoint:p3];
        [path addQuadCurveToPoint:p4 controlPoint:a2];
    }];
    return @[part, part2];
}

- (CGFloat)circleRatio:(JZHLiquittableCircle*)circle other:(JZHLiquittableCircle*)other {
    CGFloat distance = CGPointGetLength(CGPointMinus(circle.center, other.center));
    CGFloat ratio = 1.f - (distance - self.radiusTresh) / (circle.radius + other.radius + self.radiusTresh);
    return MIN(MAX(ratio, 0), 1);
}

- (BOOL)isConnected:(JZHLiquittableCircle *)circle other:(JZHLiquittableCircle *)other {
    CGFloat distance = CGPointGetLength(CGPointMinus(circle.center, other.center));
    return distance - circle.radius - other.radius < self.radiusTresh;
}

@end
