//
//  JZHDynamicCover.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHDynamicCover.h"
#import <React/RCTLog.h>

@implementation JZHDynamicCover
{
    UIDynamicAnimator* animator;
    UIGravityBehavior* gravityBehavior;
    UIPushBehavior* pushBehavior;
    UIAttachmentBehavior* attchmentBehavior;
    UIDynamicItemBehavior *itemBehaviour;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleToFill;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnIt:)];
        [self addGestureRecognizer:tap];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnIt:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setup];
    });
}

- (void) setup {
    animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.superview];

    UICollisionBehavior *collisionBehaviour = [[UICollisionBehavior alloc]initWithItems:@[self]];
    [collisionBehaviour setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(-self.frame.size.height, 0, 0, 0)];
    [animator addBehavior:collisionBehaviour];


    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self]];
    gravityBehavior.gravityDirection = CGVectorMake(0.0, 1.0);
    //    self.gravityBehaviour.angle = M_PI/3;
    gravityBehavior.magnitude = 2.6f;
    [animator addBehavior:gravityBehavior];

    pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.magnitude = 2.0f;
    pushBehavior.angle = M_PI;
    [animator addBehavior:pushBehavior];

    itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    itemBehaviour.elasticity = 0.35f;//1.0 完全弹性碰撞，需要非常久才能恢复；
    [animator addBehavior: itemBehaviour];
}

- (void)restore {
    [animator removeBehavior: gravityBehavior];
    [animator removeBehavior: itemBehaviour];
    gravityBehavior = nil;
    itemBehaviour = nil;

    //gravity
    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self]];
    gravityBehavior.gravityDirection = CGVectorMake(0.0, 1.0);
    gravityBehavior.magnitude = 2.6f;

    //item
    itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    itemBehaviour.elasticity = 0.35f;//1.0 完全弹性碰撞，需要非常久才能恢复；
    [animator addBehavior:itemBehaviour];
    [animator addBehavior:gravityBehavior];
}

#pragma mark - Gestures
-(void)tapOnIt:(UITapGestureRecognizer *)tapGes{
    pushBehavior.pushDirection = CGVectorMake(0.0f, -80.0f);
    pushBehavior.active = YES;//active is set to NO once the instantaneous force is applied. All we need to do is reactivate it on each button press.
}

-(void)panOnIt:(UIPanGestureRecognizer *)panGes{
    CGPoint location = { CGRectGetMidX(self.frame), [panGes locationInView:self.superview].y};
    switch (panGes.state) {
        case UIGestureRecognizerStateBegan: {
            [animator removeBehavior: gravityBehavior];
            attchmentBehavior = [[UIAttachmentBehavior alloc]initWithItem:self attachedToAnchor:location];
            [animator addBehavior:attchmentBehavior];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            attchmentBehavior.anchorPoint = location;
            RCTLog(@"location:%@",NSStringFromCGPoint(location));
            RCTLog(@"length:%f", attchmentBehavior.length);
        }
            break;
        case UIGestureRecognizerStateEnded: {
            CGPoint velocity = [panGes velocityInView:self];
            RCTLog(@"v:%@",NSStringFromCGPoint(velocity));
            [animator removeBehavior:attchmentBehavior];
            attchmentBehavior = nil;
            if (velocity.y < -1300.0f) {
                [animator removeBehavior:gravityBehavior];
                [animator removeBehavior:itemBehaviour];
                gravityBehavior = nil;
                itemBehaviour = nil;
                //gravity
                gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self]];
                gravityBehavior.gravityDirection = CGVectorMake(0.0, -1.0);
                gravityBehavior.magnitude = 2.6f;
                [animator addBehavior: gravityBehavior];
                //item
                itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
                itemBehaviour.elasticity = 0.0f;//1.0 完全弹性碰撞，需要非常久才能恢复；
                [animator addBehavior:itemBehaviour];
                pushBehavior.pushDirection = CGVectorMake(0.0f, -200.0f);
                pushBehavior.active = YES;
            } else {
                [self restore];
            }
        }
            break;
        default:
            break;
    }
}

@end
