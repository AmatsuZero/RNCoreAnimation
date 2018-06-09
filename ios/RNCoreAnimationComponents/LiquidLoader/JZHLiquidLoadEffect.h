//
//  JZHLoadEffect.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZHSimpleCircleLiquidEngine.h"
#import "JZHLiquittableCircle.h"

@class JZHLiquidLoader;
@interface JZHLiquidLoadEffect : NSObject

@property(nonatomic, assign)NSUInteger numberOfCircles;
@property(nonatomic, assign)NSTimeInterval duration;
@property(nonatomic, assign)CGFloat circleScale;
@property(nonatomic, assign)CGFloat moveScale;
@property(nonatomic, strong)UIColor* color;
@property(nonatomic, strong)UIColor* growColor;
@property(nonatomic, strong, nullable)JZHSimpleCircleLiquidEngine* engine;
@property(nonatomic, strong, nullable)JZHLiquittableCircle* moveCircle;
@property(nonatomic, strong, nullable)JZHLiquittableCircle* shadowCircle;
@property(nonatomic, strong, nullable)CADisplayLink* timer;
@property(nonatomic, weak, nullable)JZHLiquidLoader* loader;
@property(nonatomic, assign, getter=isGrow)BOOL grow;
@property(nonatomic, strong)NSArray<JZHLiquittableCircle*>* circles;
@property(nonatomic, assign)CGFloat circleRadius;
@property(nonatomic, assign)CGFloat key;

- (instancetype)initWithLoader:(JZHLiquidLoader*)loader
                         color:(UIColor*)color
                   circleCount:(NSUInteger)circleCount
                      duration:(CGFloat)duration
                     growColor:(UIColor*)growColr;

- (void)resize;
- (void)update;
- (void)willSetup;
- (void)setup;
- (NSArray<JZHLiquittableCircle*>*)setupShape;
- (void)grow:(BOOL)isGrow;
- (void)update:(CGFloat)keyFrame;
- (CGPoint)move:(CGFloat)position;
- (void)stopTimer;

@end
