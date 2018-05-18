//
//  JZHJumpStar.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/18.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <React/RCTLog.h>
#import "JZHJumpStar.h"

const NSTimeInterval jumpDuration = 0.125;
const NSTimeInterval downDuration = 0.215;

@interface JZHJumpStar()<CAAnimationDelegate>

@property(nonatomic,strong, nullable)UIImage *markedImage;
@property(nonatomic,strong, nullable)UIImage *non_markedImage;
@property(nonatomic,strong)UIImageView *starView;
@property(nonatomic,strong)UIImageView *shadowView;

@end

@implementation JZHJumpStar
{
    BOOL animating;
}

- (void)setTopImage:(NSString *)topImage {
    _topImage = topImage;
    _markedImage = [UIImage imageNamed:topImage];
}

- (void)setBackImage:(NSString *)backImage {
    _backImage = backImage;
    _non_markedImage = [UIImage imageNamed:backImage];
}

- (void)setMark:(BOOL)mark {
    _mark = mark;
    self.starView.image = mark ? _markedImage : _non_markedImage;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    if (self.starView == nil) {
        self.starView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - (self.bounds.size.width-6)/2, 0, self.bounds.size.width-6, self.bounds.size.height - 6)];
        self.starView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.starView];
    }
    if (self.shadowView == nil) {
        self.shadowView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - 10/2, self.bounds.size.height - 3, 10, 3)];
        self.shadowView.alpha = 0.4;
        self.shadowView.image = [UIImage imageNamed:@"shadow_new"];
        [self addSubview:self.shadowView];
    }
    self.mark = self.mark;
}

//上弹动画
-(void)animate{
    if (animating == YES) {
        return;
    }
    animating = YES;
    CABasicAnimation *transformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAnima.fromValue = @(0);
    transformAnima.toValue = @(M_PI_2);
    transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.fromValue = @(self.starView.center.y);
    positionAnima.toValue = @(self.starView.center.y - 14);
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];


    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.duration = jumpDuration;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.removedOnCompletion = NO;
    animGroup.delegate = self;
    animGroup.animations = @[transformAnima,positionAnima];

    [self.starView.layer addAnimation:animGroup forKey:@"jumpUp"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    if ([anim isEqual:[self.starView.layer animationForKey:@"jumpUp"]]) {
        [UIView animateWithDuration:jumpDuration
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            self.shadowView.alpha = 0.2;
            self.shadowView.bounds = CGRectMake(0, 0, self.shadowView.bounds.size.width*1.6, self.shadowView.bounds.size.height);
        } completion: nil];
    } else if ([anim isEqual:[self.starView.layer animationForKey:@"jumpDown"]]){
        [UIView animateWithDuration:jumpDuration
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            self.shadowView.alpha = 0.4;
            self.shadowView.bounds = CGRectMake(0, 0, self.shadowView.bounds.size.width/1.6, self.shadowView.bounds.size.height);
        } completion: nil];

    }
}

//下落动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isEqual:[self.starView.layer animationForKey:@"jumpUp"]]) {
        self.mark = !self.mark;
        RCTLog(@"%@", self.isMark ? @"Top": @"Back");
        CABasicAnimation *transformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        transformAnima.fromValue = @(M_PI_2);
        transformAnima.toValue = @(M_PI);
        transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
        positionAnima.fromValue = @(self.starView.center.y - 14);
        positionAnima.toValue = @(self.starView.center.y);
        positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.duration = downDuration;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.removedOnCompletion = NO;
        animGroup.delegate = self;
        animGroup.animations = @[transformAnima,positionAnima];
        [self.starView.layer addAnimation:animGroup forKey:@"jumpDown"];
    } else if([anim isEqual:[self.starView.layer animationForKey:@"jumpDown"]]){
        [self.starView.layer removeAllAnimations];
        animating = NO;
    }
}

@end
