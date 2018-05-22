//
//  JZHStarOverlay.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/22.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHStarOverlayView.h"

@implementation JZHStarOverlayView {
    UIImage* _Nullable overlayImage;
    CAEmitterLayer* emitter;
    CAEmitterCell* particle;
    NSTimer* timer;
}

+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (instancetype)init {
    if (self = [super init]) {
        emitter = (CAEmitterLayer*)self.layer;
        emitter.emitterShape = kCAEmitterLayerCircle;
        emitter.renderMode = kCAEmitterLayerOldestFirst;
        emitter.preservesDepth = YES;

        particle = [CAEmitterCell emitterCell];
        particle.birthRate = 10;
        particle.lifetime = 50;
        particle.lifetimeRange = 5;
        particle.velocity = 20;
        particle.velocityRange = 10;

        particle.scale = 0.02;
        particle.scaleRange = 0.1;
        particle.scaleSpeed = 0.02;

        emitter.emitterCells = @[particle];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    emitter.emitterPosition = self.center;
    emitter.emitterSize = self.bounds.size;
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window) {
        if (!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                     target:self
                                                   selector:@selector(randomizeEmitterPosition)
                                                   userInfo:nil
                                                    repeats:YES];
        }
    } else if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)setEmitImage:(NSString *)emitImage {
    _emitImage = [emitImage copy];
    overlayImage = [UIImage imageNamed:emitImage] ?: [UIImage imageWithContentsOfFile:emitImage];
    particle.contents = (__bridge id _Nullable)(overlayImage.CGImage);
}

- (void)randomizeEmitterPosition {
    CGFloat sizeWidth = MAX(self.bounds.size.width, self.bounds.size.height);
    CGFloat radius = fmod((CGFloat)arc4random(), sizeWidth);
    emitter.emitterSize = CGSizeMake(radius, radius);
    particle.birthRate = 10 + sqrtf(radius);
}

@end
