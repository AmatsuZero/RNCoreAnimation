//
//  JZHFavoriteButton.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/28.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHFavoriteButton.h"
#import "NSString+JZHColorConvertor.h"

@implementation JZHFavoriteButton
{
    CAShapeLayer* imageShape;
    CAShapeLayer* circleShape;
    CAShapeLayer* circleMask;
    NSMutableArray<CAShapeLayer*>* lines;
    UIImage* actualImage;
    UIColor* onColor;
    UIColor* offColor;
    UIColor* circleCol;
    UIColor* lineCol;
    BOOL preselected;
    BOOL isInit;
    // Animation
    CAKeyframeAnimation* circleTransform;
    CAKeyframeAnimation* circleMaskTransform;
    CAKeyframeAnimation* lineStrokeStart;
    CAKeyframeAnimation* lineStrokeEnd;
    CAKeyframeAnimation* lineOpacity;
    CAKeyframeAnimation* imageTransform;
    // Frame
    CGRect imageFrame;
    CGRect lineFrame;
    CGPoint imageCenterPoint;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        onColor = [UIColor colorWithRed:255/255.f green:172/255.f blue:51/255.f alpha:1];
        offColor = [UIColor colorWithRed:136/255.f green:153/255.f blue:166/255.f alpha:1];
        circleCol = [UIColor colorWithRed:255/255.f green:172/255.f blue:51/255.f alpha:1];
        lineCol = [UIColor colorWithRed:250/255.f green:120/255.f blue:68/255.f alpha:1];
        lines = [NSMutableArray array];
        circleTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleMaskTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        lineStrokeStart = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        lineStrokeEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        lineOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        imageTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        [self addTargets];
        preselected = NO;
        isInit = NO;
    }
    return self;
}

- (void)layoutSubviews {// addSubLayer也会触发调用此方法
    [super layoutSubviews];
    imageFrame = CGRectMake(CGRectGetWidth(self.frame)/2 - CGRectGetWidth(self.frame)/4,
                            CGRectGetHeight(self.frame)/2 - CGRectGetHeight(self.frame)/4,
                            CGRectGetWidth(self.frame)/2,
                            CGRectGetHeight(self.frame)/2);
    imageCenterPoint = CGPointMake(CGRectGetMidX(imageFrame), CGRectGetMidY(imageFrame));
    lineFrame = CGRectMake(CGRectGetMinX(imageFrame) - CGRectGetWidth(imageFrame)/4,
                           CGRectGetMinY(imageFrame) - CGRectGetHeight(imageFrame)/4,
                           CGRectGetWidth(imageFrame)*1.5,
                           CGRectGetHeight(imageFrame)*1.5);
    if (!isInit) {
        isInit = YES;
        [self createLayers:actualImage ?: [UIImage new]];
    }
}

- (void)createLayers:(UIImage*)image {
    self.layer.sublayers = nil;
    // Circle Layer
    circleShape = [CAShapeLayer layer];
    circleShape.bounds = imageFrame;
    circleShape.position = imageCenterPoint;
    circleShape.path = [UIBezierPath bezierPathWithOvalInRect:imageFrame].CGPath;
    circleShape.fillColor = circleCol.CGColor;
    circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0);
    [self.layer addSublayer:circleShape];

    circleMask = [CAShapeLayer layer];
    circleMask.bounds = imageFrame;
    circleMask.position = imageCenterPoint;
    circleMask.fillRule = kCAFillRuleEvenOdd;
    circleShape.mask = circleMask;

    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRect:imageFrame];
    [maskPath addArcWithCenter:imageCenterPoint radius:0.1 startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    circleMask.path = maskPath.CGPath;

    [lines removeAllObjects];
    for (int i = 0; i < 5; i++) {
        CAShapeLayer* line = [CAShapeLayer layer];
        line.bounds = lineFrame;
        line.position = imageCenterPoint;
        line.masksToBounds = YES;
        line.actions = @{@"strokeStart": [NSNull null],
                         @"strokeEnd": [NSNull null]};
        line.strokeColor = lineCol.CGColor;
        line.lineWidth = 1.25;
        line.miterLimit = 1.25;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, CGRectGetMidX(lineFrame), CGRectGetMidY(lineFrame));
        CGPathAddLineToPoint(path, NULL,CGRectGetMinX(lineFrame) + CGRectGetWidth(lineFrame) / 2, CGRectGetMinY(lineFrame));
        line.path = path;
        line.lineCap = kCALineCapRound;
        line.lineJoin = kCALineJoinRound;
        line.strokeStart = 0.0;
        line.strokeEnd = 0.0;
        line.opacity = 0.0;
        line.transform = CATransform3DMakeRotation(M_PI/5*(CGFloat)(i*2+1), 0, 0, 1);
        [self.layer addSublayer:line];
        [lines addObject:line];
        CGPathRelease(path);
    }

    imageShape = [CAShapeLayer layer];
    imageShape.bounds = imageFrame;
    imageShape.position = imageCenterPoint;
    imageShape.path = [UIBezierPath bezierPathWithRect:imageFrame].CGPath;
    imageShape.fillColor = offColor.CGColor;
    imageShape.actions = @{@"fillColor": [NSNull null]};
    [self.layer addSublayer:imageShape];

    imageShape.mask = [CALayer layer];
    imageShape.mask.contents = (__bridge id _Nullable)(image.CGImage);
    imageShape.mask.bounds = imageFrame;
    imageShape.mask.position = imageCenterPoint;

    circleTransform.duration = 0.333;
    circleTransform.values = @[
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,  0.0,  1.0)], // 0 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.5,  0.5,  1.0)], // 1 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0,  1.0,  1.0)], // 2 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,  1.2,  1.0)], // 3 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.3,  1.3,  1.0)], // 4 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.37, 1.37, 1.0)], // 5 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0)], // 6 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0)] // 10 / 10
                               ];
    circleTransform.keyTimes = @[@0.f, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @1.f];

    circleMaskTransform.duration = 0.333;
    circleMaskTransform.values = @[
                                   [NSValue valueWithCATransform3D: CATransform3DIdentity], // 0 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DIdentity], // 2 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(CGRectGetWidth(imageFrame) * 1.25,  CGRectGetHeight(imageFrame) * 1.25,  1.0)], // 3 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(CGRectGetWidth(imageFrame) * 2.688,  CGRectGetHeight(imageFrame) * 2.688,  1.0)], // 4 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(CGRectGetWidth(imageFrame) * 3.923,  CGRectGetHeight(imageFrame) * 3.923,  1.0)], // 5 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(CGRectGetWidth(imageFrame) * 4.375, CGRectGetHeight(imageFrame) * 4.375, 1.0)], // 6 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(CGRectGetWidth(imageFrame) * 4.731,  CGRectGetHeight(imageFrame) * 4.731,  1.0)], // 7 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(CGRectGetWidth(imageFrame) * 5.0,  CGRectGetHeight(imageFrame) * 5.0,  1.0)], // 9 / 10
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(CGRectGetWidth(imageFrame) * 5.0,  CGRectGetHeight(imageFrame) * 5.0,  1.0)] // 10 / 10
                                   ];
    circleMaskTransform.keyTimes = @[@0.f, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.9, @1.f];

    lineStrokeStart.duration  = 0.6;
    lineStrokeStart.values =  @[@0.f, @0.f, @0.18, @0.2, @0.26, @0.32, @0.4, @0.6, @0.71, @0.89, @0.92];
    lineStrokeStart.keyTimes =  @[@0.f, @0.056, @0.111, @0.167, @0.222, @0.278, @0.333, @0.389, @0.444, @0.944, @1.f];

    lineStrokeEnd.duration = 0.6;
    lineStrokeEnd.values =  @[@0.f, @0.f, @0.32, @0.48, @0.64, @0.68, @0.92, @0.92];
    lineStrokeEnd.keyTimes =  @[@0.f, @0.056, @0.111, @0.167, @0.222, @0.278, @0.944, @1.f];

    lineOpacity.duration = 1.0;
    lineOpacity.values = @[@1.f, @1.f, @0.f];
    lineOpacity.keyTimes = @[@0.f, @0.4, @0.567];

    imageTransform.duration = 1.0;
    imageTransform.values =  @[
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,  0.0,  1.0)], // 0 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,  0.0,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.5,  0.5,  1.0)], // 1 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,  1.2,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.25,  1.25,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,  1.2,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.9,  0.9,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.875,  0.875,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.875,  0.875,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.9,  0.9,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.013,  1.013,  1.0)], // 2 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.025,  1.025,  1.0)], // 3 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.013,  1.013,  1.0)], // 2 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.96, 0.96,  1.0)], // 4 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.95, 0.95, 1.0)], // 5 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.96, 0.96,  1.0)], // 6 / 10
                               [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.99,  0.99,  1.0)],
                               [NSValue valueWithCATransform3D: CATransform3DIdentity] // 10 / 10
                               ];
    imageTransform.keyTimes = @[@0.f, @0.1, @0.3, @0.333, @367, @467, @0.5, @0.533, @0.567, @0.667, @0.7, @0.733, @0.833, @0.867, @0.9, @0.967, @1.f];
}

#pragma mark - Setters
- (void)setImage:(NSString *)image {
    _image = [image copy];
    actualImage = [UIImage imageNamed:image] ?: [UIImage imageWithContentsOfFile:image];
    if (isInit) {
        [self createLayers:actualImage];
    }
}

- (void)setImageColorOn:(NSString *)imageColorOn {
    _imageColorOn = [imageColorOn copy];
    onColor = [imageColorOn hexToColor];
    if (self.selected && onColor) {
        imageShape.fillColor = onColor.CGColor;
    }
}

- (void)setImageColorOff:(NSString *)imageColorOff {
    _imageColorOff = [imageColorOff copy];
    offColor = [imageColorOff hexToColor];
    if (!self.selected && offColor) {
        imageShape.fillColor = offColor.CGColor;
    }
}

- (void)setCircleColor:(NSString *)circleColor {
    _circleColor = [circleColor copy];
    circleCol = [circleColor hexToColor];
    if (circleCol) {
        circleShape.fillColor = circleCol.CGColor;
    }
}

- (void)setLineColor:(NSString *)lineColor {
    _lineColor = [lineCol copy];
    lineCol = [lineColor hexToColor];
    if (lineCol) {
        [lines enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
            [line setStrokeColor:self->lineCol.CGColor];
        }];
    }
}

- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    circleMaskTransform.duration = 0.333 * duration;
    circleMaskTransform.duration = 0.333 * duration;
    lineStrokeStart.duration = 0.333 * duration;
    lineStrokeEnd.duration = 0.333 * duration;
    lineOpacity.duration = 1.0 * duration;
    imageTransform.duration = 1.0 * duration;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (preselected == self.isSelected) {
        return;
    }
    preselected = selected;
    if (self.isSelected) {
        imageShape.fillColor = onColor.CGColor;
    } else {
        [self deselect];
    }

}

- (void)select {
    self.selected = YES;
    imageShape.fillColor = onColor.CGColor;
    [CATransaction begin];
    [circleShape addAnimation:circleTransform forKey:@"transform"];
    [circleMask addAnimation:circleMaskTransform forKey:@"transform"];
    [imageShape addAnimation:imageTransform forKey:@"transform"];

    [lines enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
        [line addAnimation:self->lineStrokeStart forKey:@"strokeStart"];
        [line addAnimation:self->lineStrokeEnd forKey:@"strokeEnd"];
        [line addAnimation:self->lineOpacity forKey:@"opacity"];
    }];
    [CATransaction commit];

    if (self.onSelect) {
        self.onSelect(nil);
    }
}

- (void)deselect {
    self.selected = NO;
    imageShape.fillColor = offColor.CGColor;
    // remove all animations
    [circleShape removeAllAnimations];
    [circleMask removeAllAnimations];
    [imageShape removeAllAnimations];
    [lines enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
        [line removeAllAnimations];
    }];
    if (self.onDeselect) {
        self.onDeselect(nil);
    }
}

#pragma mark - Touch Handler
- (void)addTargets {
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(touchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
}

- (void)touchDown:(JZHFavoriteButton*)sender {
    self.layer.opacity = 0.4;
}

- (void)touchUpInside:(JZHFavoriteButton*)sender {
    self.layer.opacity = 1.0;
}

- (void)touchDragExit:(JZHFavoriteButton*)sender {
    self.layer.opacity = 1.0;
}

- (void)touchDragEnter:(JZHFavoriteButton*)sender {
    self.layer.opacity = 0.4;
}

- (void)touchCancel:(JZHFavoriteButton*)sender {
    self.layer.opacity = 1.0;
}

@end
