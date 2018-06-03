//
//  UIColor+JZHGrow.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "UIView+JZHGrow.h"
#import "JZHCGValueManipulation.h"

@implementation UIView (JZHGrow)

- (void)growWithBaseColor:(UIColor *)baseColor
                   radius:(CGFloat)radius
                shininess:(CGFloat)shininess {
    NSArray* sublayers = self.layer.sublayers;
    if (!sublayers) { return; }
    [self growShadowWithColor:baseColor radius:radius shininess:shininess];
    CAShapeLayer* circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, radius*2, radius*2)].CGPath;
    
}

- (void)growShadowWithColor:(UIColor *)growColor
                     radius:(CGFloat)radius
                  shininess:(CGFloat)shininess {
    CGPoint origin = CGPointMinus(CGPointMinus(self.center, self.frame.origin), CGPointMake(radius*shininess, radius*shininess));
    CGRect ovalRect = CGRectMake(origin.x, origin.y, 2*radius*shininess, 2*radius*shininess);
    UIBezierPath* shadowPath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    self.layer.shadowColor = growColor.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.shadowOffset= CGSizeZero;
    self.layer.masksToBounds = NO;
    self.clipsToBounds = YES;
}

@end
