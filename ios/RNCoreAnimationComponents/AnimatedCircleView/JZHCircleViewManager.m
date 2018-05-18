//
//  JZHCircleViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import "JZHCircleViewManager.h"
#import "JZHCircleView.h"

@implementation JZHCircleViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(progress, CGFloat)
- (__kindof UIView *)view {
    return [[JZHCircleView alloc] init];
}

@end
