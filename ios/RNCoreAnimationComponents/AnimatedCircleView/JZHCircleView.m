//
//  JZHCircleView.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHCircleView.h"

@implementation JZHCircleView

+(Class)layerClass {
    return [JZHCircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _circleLayer = [JZHCircleLayer layer];
        _circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

@end
