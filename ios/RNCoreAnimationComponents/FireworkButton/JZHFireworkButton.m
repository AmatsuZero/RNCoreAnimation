//
//  JZHFireworkButton.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHFireworkButton.h"
#import "JZHFireworkView.h"

@implementation JZHFireworkButton
{
    JZHFireworkView* fireworksView;
    UIImage* _Nullable activeImg;
    UIImage* _Nullable inactiveImg;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        fireworksView = [[JZHFireworkView alloc] init];
        [self insertSubview:fireworksView atIndex:0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    fireworksView.frame = self.bounds;
    [self insertSubview:fireworksView atIndex:0];
}

#pragma mark - Methods

- (void)animate {
    [fireworksView animate];
}

- (void)popOutsideWithDuration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}

- (void)popInsideWithDuration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 2.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}

#pragma mark - Properties
-(void)setParticleImageName:(NSString *)particleImageName {
    UIImage* img = [UIImage imageNamed:particleImageName];
    fireworksView.particleImage = img;
}

- (CGFloat)particleScale {
    return fireworksView.particleScale;
}

- (void)setParticleScale:(CGFloat)particleScale {
    fireworksView.particleScale = particleScale;
}

- (CGFloat)particleScaleRange {
    return fireworksView.particleScaleRange;
}

- (void) setParticleScaleRange:(CGFloat)particleScaleRange {
   fireworksView.particleScaleRange = particleScaleRange;
}

- (void)setActiveImageName:(NSString *)activeImageName {
    _activeImageName = activeImageName;
    activeImg = [UIImage imageNamed:activeImageName];
}

- (void)setInactiveImageName:(NSString *)inactiveImageName {
    _inactiveImageName = inactiveImageName;
    inactiveImg = [UIImage imageNamed:inactiveImageName];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self popInsideWithDuration:selected ? 0.5 : 0.4];
    [self setImage: selected ? activeImg : inactiveImg forState:UIControlStateNormal];
    if (selected) {
        [self animate];
        if (self.activeCallback) {
             self.activeCallback(nil);
        }
    } else if (self.disactiveCallback) {
        self.disactiveCallback(nil);
    }
}

@end
