//
//  JZHAnimatedTextView.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/20.
//  Copyright © 2018年 Daubert. All rights reserved.
//
@import CoreText;
#import <React/RCTLog.h>
#import "JZHAnimatedTextView.h"

@interface JZHAnimatedTextView()
{
    /// 渐变色Layer
    CAGradientLayer* gradientLayer;
    /// 字迹图层
    CAShapeLayer* pathLayer;
}
@end

@implementation JZHAnimatedTextView

- (instancetype)init {
    if (self = [super init]) {
        gradientLayer = [CAGradientLayer layer];
        pathLayer = [CAShapeLayer layer];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    gradientLayer.frame = self.bounds;
    pathLayer.position = gradientLayer.position;
}

- (void)setDelayTime:(NSTimeInterval)delayTime {
    _delayTime = delayTime;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(delayTime * 100 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [self addGradientLayer];
                       [self addPathLayer: self.message];
                       self->gradientLayer.mask = self->pathLayer;
                   });
}

/// 添加渐变色Layer和动画
-(void)addGradientLayer {
    NSMutableArray* colors = [NSMutableArray array];
    // 渐变色颜色数
    NSInteger count = 30;
    UIColor* topColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
    UIColor* bottomColor = [UIColor colorWithRed:24/255.0 green:25/255.0 blue:2/255.0 alpha:1];
    NSArray* gradientColors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    for (int i = 0; i < count; i++) {
        UIColor* color = [UIColor colorWithRed:(CGFloat)(arc4random()%256)/255.f
                                         green:(CGFloat)(arc4random()%256)/255.f
                                          blue:(CGFloat)(arc4random()%256)/255.f
                                         alpha:1];
        [colors addObject:(id)color.CGColor];
    }
    RCTLog(@"%@", gradientLayer);
    // 渐变色方向
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    gradientLayer.colors = gradientColors;
    gradientLayer.type = kCAGradientLayerAxial;
    [self.layer addSublayer:gradientLayer];
    // 渐变色动画
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 0.5;
    animation.repeatCount = MAXFLOAT;

    NSMutableArray* toColors = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        UIColor* color = [UIColor colorWithRed:(CGFloat)(arc4random()%256)/255.f
                                         green:(CGFloat)(arc4random()%256)/255.f
                                          blue:(CGFloat)(arc4random()%256)/255.f
                                         alpha:1];
        [toColors addObject:(id)color.CGColor];
    }
    animation.autoreverses = YES;
    animation.toValue = toColors;
    [self->gradientLayer addAnimation:animation forKey:@"gradientLayer"];
}

- (void) addPathLayer:(NSString*)message {
    UIBezierPath* textPath = [self bezierPathFrom:message];
    pathLayer.bounds = CGPathGetBoundingBox(textPath.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = textPath.CGPath;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1;
    pathLayer.strokeColor = [UIColor blackColor].CGColor;
    //笔迹动画
    CABasicAnimation* textAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    textAnimation.duration = self.duration;
    textAnimation.fromValue = @0;
    textAnimation.toValue = @1;
    textAnimation.autoreverses = YES;
    [self->pathLayer addAnimation:textAnimation forKey:@"strokeEnd"];
}

/// 绘制贝塞尔曲线
- (UIBezierPath*)bezierPathFrom:(NSString*)string {
    CGMutablePathRef paths = CGPathCreateMutable();
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)self.fontName, 25, NULL);
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:@{(__bridge_transfer NSString*)kCTFontAttributeName: (__bridge id)fontRef}];
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    CFArrayRef runA = CTLineGetGlyphRuns(line);

    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runA); runIndex++) {
        // Get font for this run
        CTRunRef run = CFArrayGetValueAtIndex(runA, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        // for each GLyph in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            // get Glyph & glyph-data
            CFRange thisGlyRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyRange, &glyph);
            CTRunGetPositions(run, thisGlyRange, &position);
            // Get path of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(paths, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    return path;
}

@end
