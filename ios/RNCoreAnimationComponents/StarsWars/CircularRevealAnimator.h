//
//  CircularRevealAnimator.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/22.
//  Copyright © 2018年 Daubert. All rights reserved.
//
@import QuartzCore;
#import <Foundation/Foundation.h>

@interface CircularRevealAnimator : NSObject

@property(nonatomic, copy, nullable)void (^completion)(void);
@property(nonatomic, assign)CFTimeInterval duration;
@property(nonatomic, strong)CAMediaTimingFunction* timingFunction;

- (instancetype)initWithLayer:(CALayer*)layer center:(CGPoint)center startRadius:(CGFloat)startRadius endRadius:(CGFloat)endRadius invert:(BOOL)isVert;

- (void)start;

@end
