//
//  JZHDrawingboardView.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/21.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <React/RCTLog.h>
#import "JZHDrawingboardView.h"
#import "NSString+JZHColorConvertor.h"

@implementation JZHDrawingboardView {
    NSMutableArray<UIBezierPath*>* _Nonnull paths;
    NSMutableArray<UIColor*>* _Nonnull colorArray;
    NSTimer* timer;
    BOOL isPlaying;
    UIColor* _Nonnull drawColor;
}

static NSUInteger step = 0;

- (void)setColor:(NSString *)color {
    _color = [color copy];
    drawColor = [color hexToColor] ?: [UIColor blackColor];
}

- (instancetype)init {
    if (self = [super init]) {
        paths = [NSMutableArray arrayWithObject:[UIBezierPath bezierPath]];
        colorArray = [NSMutableArray arrayWithObject:[UIColor blackColor]];
        drawColor = [UIColor blackColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(__unused UIEvent *)event {
    // 1.获得当前的触摸点
    UITouch *touch = [touches anyObject];
    CGPoint startPos = [touch locationInView:touch.view];
    // 2.创建一个新的路径
    UIBezierPath *currenPath = [UIBezierPath bezierPath];
    currenPath.lineCapStyle = kCGLineCapRound;
    currenPath.lineJoinStyle = kCGLineJoinRound;
    currenPath.lineWidth = 10;
    // 设置起点
    [currenPath moveToPoint:startPos];
    // 3.添加路径到数组中
    [paths addObject:currenPath];
    [colorArray addObject:[drawColor copy]];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInView:touch.view];
    UIBezierPath *currentPath = [paths lastObject];
    [currentPath addLineToPoint:pos];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (paths.count == 0) return;
    if (isPlaying) {
        for (int i = 0; i< step; i++) {
            UIColor * color = colorArray[i];
            [color set];
            UIBezierPath * path = paths[i];
            [path stroke];
        }
        if (step>= paths.count) {
            [timer invalidate];
            isPlaying = NO;
            step = 0;
            return;
        }
    } else {
        for (int i = 0; i < paths.count; i++) {
            UIColor * color = colorArray[i];
            [color set];
            UIBezierPath * path = paths[i];
            [path stroke];
        }
    }
}

#pragma mark - Control
- (void)clear {
    paths = [NSMutableArray arrayWithObject:[UIColor blackColor]];
    colorArray = [NSMutableArray arrayWithObject:[UIBezierPath bezierPath]];
    [self setNeedsDisplay];
}

- (void)back {
    [paths removeLastObject];
    [colorArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)playView {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(playDraw)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)capture {
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    // 2.将控制器view的layer渲染到上下文
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 4.结束上下文
    UIGraphicsEndImageContext();
    // 5.保存到图片
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)playDraw {
    step ++;
    isPlaying = YES;
    [self setNeedsDisplay];
}

- (void)image:(__unused UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(__unused void*)contextInfo {
    if (error)  // 保存失败
        RCTLogError(@"保存失败: %@", error);
    else  // 保存成功
        RCTLog(@"sucess");
}

#pragma mark - Demo
- (void)playDemo {
    [paths removeAllObjects];
    [colorArray removeAllObjects];
    step = 12;
    //1. 左边蝴蝶结
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 7;
    [path moveToPoint:CGPointMake(216, 45)];
    [path addCurveToPoint:CGPointMake(160, -60)
            controlPoint1:CGPointMake(115, 120)
            controlPoint2:CGPointMake(193, 77)];
    [paths addObject:[path copy]];
    [colorArray addObject:[UIColor blackColor]];
    // 2. 右边蝴蝶结
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(238, 55)];
    [path addCurveToPoint:CGPointMake(330, 30)
            controlPoint1:CGPointMake(250, 170)
            controlPoint2:CGPointMake(221, 94)];
    [paths addObject: [path copy]];
    [colorArray addObject:[UIColor blackColor]];
    

    UIBezierPath *currenPath = [UIBezierPath bezierPath];
    currenPath.lineCapStyle = kCGLineCapRound;
    currenPath.lineJoinStyle = kCGLineJoinRound;
    currenPath.lineWidth = 7;
}

@end
