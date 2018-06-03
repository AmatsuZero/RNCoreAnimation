//
//  JZHLoadEffect.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHLiquidLoadEffect.h"

@implementation JZHLiquidLoadEffect

- (instancetype)initWithLoader:(JZHLiquidLoader *)loader
                         color:(UIColor *)color
                   circleCount:(NSUInteger)circleCount
                      duration:(CGFloat)duration
                     growColor:(UIColor *)growColr {
    if (self = [super init]) {
        _numberOfCircles = circleCount;
        _duration = duration;
        _circleRadius = CGRectGetWidth(loader.frame)*0.05;
        _loader = loader;
        _color = color;
        _growColor = growColr ?: [UIColor redColor];
        _key = 0;
        _circleScale = 1.17;
        _moveScale = .8;
        [self setup];
    }
    return self;
}

- (void)setGrow:(BOOL)grow {
    _grow = grow;
    [self grow:grow];
}

- (void)setKey:(CGFloat)key {
    _key = key;
    [self update:key];
}

- (void)setup {
    [self willSetup];
    self.engine.color = self.color;
    self.circles = [self setupShape];
    [self.circles enumerateObjectsUsingBlock:^(JZHLiquittableCircle * _Nonnull circle, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.loader addSubview:circle];
    }];
    if (self.moveCircle) {
        [self.loader addSubview:self.moveCircle];
    }
    [self resize];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)update:(CGFloat)keyFrame {
    [self.engine clear];
    CGPoint movePos = [self move:keyFrame];
    
    self.moveCircle.center = movePos;
    self.shadowCircle.center = movePos;
    [self.circles enumerateObjectsUsingBlock:^(JZHLiquittableCircle * _Nonnull circle, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.moveCircle) {
            [self.engine push:self.moveCircle other: circle];
        }
    }];
    [self resize];
    if (self.loader) {
        [self.engine draw:self.loader];
    }
    if (self.shadowCircle) {
        [self.loader bringSubviewToFront:self.shadowCircle];
    }
}

- (void)resize {
    
}

- (NSArray<JZHLiquittableCircle *> *)setupShape {
    return @[];
}

- (CGPoint)move:(CGFloat)position {
    return CGPointZero;
}

- (void)grow:(BOOL)isGrow {
    if (self.isGrow) {
        self.shadowCircle = [[JZHLiquittableCircle alloc] initWithCenter:self.moveCircle.center radius:self.moveCircle.radius*1.f color:self.color growColor:self.growColor];
        self.shadowCircle.grow = isGrow;
        [self.loader addSubview:self.shadowCircle];
    } else {
        [self.shadowCircle removeFromSuperview];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)update {
    
}

- (void)willSetup{
    
}

@end
