//
//  JZHCardView.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHCardView.h"
#import <React/RCTLog.h>

@implementation JZHCardView {
    UIImageView *cardImageView;
    UIImageView *cardParallaxView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setUpSomething];
    });
}

#pragma mark -- helper
-(void)setUpSomething{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 10);
    self.layer.shadowRadius = 10.0f;
    self.layer.shadowOpacity = 0.3f;

    cardImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    cardImageView.layer.cornerRadius = 5.0f;
    cardImageView.clipsToBounds = YES;
    [self addSubview:cardImageView];

    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panInCard:)];
    [self addGestureRecognizer:panGes];

    cardParallaxView = [[UIImageView alloc]initWithFrame:cardImageView.frame];
    cardParallaxView.layer.transform = CATransform3DTranslate(cardParallaxView.layer.transform, 0, 0, 200);
    [self insertSubview:cardParallaxView aboveSubview:cardImageView];
}

-(void)panInCard:(UIPanGestureRecognizer *)panGes {

    CGPoint touchPoint = [panGes locationInView:self];
    if (panGes.state == UIGestureRecognizerStateChanged) {

        CGFloat xFactor = MIN(1, MAX(-1,(touchPoint.x - (self.bounds.size.width/2)) / (self.bounds.size.width/2)));
        CGFloat yFactor = MIN(1, MAX(-1,(touchPoint.y - (self.bounds.size.height/2)) / (self.bounds.size.height/2)));

        cardImageView.layer.transform = [self transformWithM34:1.0/-500 xf:xFactor yf:yFactor];
        cardParallaxView.layer.transform = [self transformWithM34:1.0/-250 xf:xFactor yf:yFactor];

        CGFloat zFactor = 180 * atan(yFactor/xFactor) / M_PI+90;
        RCTLog(@"%f",zFactor);

    } else if (panGes.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.3 animations:^{
            self->cardImageView.layer.transform = CATransform3DIdentity;
            self->cardParallaxView.layer.transform = CATransform3DIdentity;
        } completion: nil];
    }
}

-(CATransform3D )transformWithM34:(CGFloat)m34 xf:(CGFloat)xf yf:(CGFloat)yf{
    CATransform3D t = CATransform3DIdentity;
    t.m34  = m34;
    t = CATransform3DRotate(t, M_PI/9 * yf, -1, 0, 0);
    t = CATransform3DRotate(t, M_PI/9 * xf, 0, 1, 0);
    return t;
}

- (void)setCardImageName:(NSString *)cardImageName {
    _cardImageName = cardImageName;
    cardImageView.image = [UIImage imageNamed:cardImageName];
}

- (void)setCardParallaxImageName:(NSString *)cardParallaxImageName {
    _cardParallaxImageName = cardParallaxImageName;
    cardParallaxView.image = [UIImage imageNamed:cardParallaxImageName];
}

@end
