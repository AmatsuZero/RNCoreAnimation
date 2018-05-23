//
//  JZHStarWarsGLAnimator.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHStarWarsGLAnimator.h"
#import "JZHSpriteRender.h"

@interface JZHStarWarsGLAnimator()<GLKViewDelegate>
{
    NSMutableArray<JZHSprite*>* sprites;
    EAGLContext* glContext;
    GLKBaseEffect* effect;
    GLKView* glView;
    CADisplayLink* _Nullable displayLink;
    NSTimeInterval lastUpdateTime;
    NSTimeInterval startTransitionTime;
    id<UIViewControllerContextTransitioning> transitionContext;
    JZHSpriteRender* render;
}
@end

@implementation JZHStarWarsGLAnimator

- (instancetype)init {
    if (self = [super init]) {
        lastUpdateTime = -1;
        sprites = [NSMutableArray array];
    }
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView* containerView = [transitionContext containerView];
    UIView* fromView = [[transitionContext viewControllerForKey:UITransitionContextFromViewKey] view];
    UIView* toView = [[transitionContext viewControllerForKey:UITransitionContextToViewKey] view];

    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];

    float(^randomFloatBetween)(CGFloat, CGFloat) = ^(CGFloat small, CGFloat big) {
        return fmodf((CGFloat)(arc4random()/100.f), big -small) + (float)small;
    };

    glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:glContext];

    glView = [[GLKView alloc] initWithFrame:fromView.frame context:glContext];
    glView.enableSetNeedsDisplay = YES;
    glView.delegate = self;
    glView.opaque = YES;
    [containerView addSubview:glView];

    JZHViewTexture* texture = [[JZHViewTexture alloc] init];
    [texture setupOpenGL];
    [texture render:fromView];

    effect = [[GLKBaseEffect alloc] init];
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, texture->width, 0, texture->height, -1, 1);
    effect.transform.projectionMatrix = projectionMatrix;

    render = [[JZHSpriteRender alloc] initWithTexture:texture effect:effect];

    CGSize size = CGSizeMake(texture->width, texture->height);
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = self.spriteWidth * scale;
    CGFloat height = width;

    for (CGFloat x = 0;  x < size.width; x += width) {
        for (CGFloat y = 0; y < size.height; y += height) {
            CGRect region = CGRectMake(x, y, width, height);
            JZHSprite* sprite = [[JZHSprite alloc] init];
            [sprite slice:region textureSize:size];
            sprite.moveVelocity = GLKVector2Make(randomFloatBetween(-100, 100),
                                                 randomFloatBetween(-texture->height/1.3, texture->height/self.duration));
            [sprites addObject:sprite];
        }
    }
    [fromView removeFromSuperview];
    self->transitionContext = transitionContext;

    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
    displayLink.paused = YES;
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

    startTransitionTime = [NSDate timeIntervalSinceReferenceDate];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)displayLinkTick:(CADisplayLink*)displayLink {
    if (lastUpdateTime > 0) {
        NSTimeInterval timeSinceLastUpdate = [NSDate timeIntervalSinceReferenceDate] - lastUpdateTime;
        [sprites enumerateObjectsUsingBlock:^(JZHSprite * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj update:timeSinceLastUpdate];
        }];
    }
    lastUpdateTime = [NSDate timeIntervalSinceReferenceDate];

    [glView setNeedsDisplay];
    if ([NSDate timeIntervalSinceReferenceDate] - startTransitionTime > self.duration) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }
}

- (void)animationEnded:(BOOL)transitionCompleted {
    [displayLink invalidate];
    displayLink = nil;
}

- (void)glkView:(nonnull GLKView *)view drawInRect:(__unused CGRect)rect {
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_DST_ALPHA);
    glEnable(GL_BLEND);

    [render render:sprites];
}

@end
