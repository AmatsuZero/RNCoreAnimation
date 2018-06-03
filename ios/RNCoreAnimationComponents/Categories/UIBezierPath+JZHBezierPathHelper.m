//
//  UIBezierPath+JZHBezierPathHelper.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "UIBezierPath+JZHBezierPathHelper.h"

@implementation UIBezierPath (JZHBezierPathHelper)

+ (UIBezierPath *)with:(void (^)(UIBezierPath *))block {
    UIBezierPath* path = [UIBezierPath bezierPath];
    block(path);
    [path closePath];
    return path;
}

- (void)strokeWithColor:(UIColor *)color handler:(void (^)(void))block {
    [color setStroke];
    block();
    [self stroke];
}

- (void)fillWithColor:(UIColor *)color handler:(void (^)(void))block {
    [color setFill];
    block();
    [self fill];
}

@end
