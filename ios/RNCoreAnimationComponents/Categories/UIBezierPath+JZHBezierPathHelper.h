//
//  UIBezierPath+JZHBezierPathHelper.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

NSArray<NSNumber*>* CGMathLineSpace(CGFloat from, CGFloat to, NSUInteger n) {
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:n];
    for (NSUInteger i = 0; i < n; i++) {
        [array addObject:@((to - from) * n / (n-1) + from)];
    }
    return array;
}

@interface UIBezierPath (JZHBezierPathHelper)

+ (UIBezierPath*)with:(void(^)(UIBezierPath*))block;

- (void)strokeWithColor:(UIColor*)color handler:(void(^)(void))block;

- (void)fillWithColor:(UIColor*)color handler:(void(^)(void))block;


@end
