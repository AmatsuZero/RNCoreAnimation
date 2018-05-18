//
//  JZHPulseLoaderViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/18.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import "JZHPulseLoaderViewManager.h"
#import "JZHPulseLoaderView.h"

@implementation JZHPulseLoaderViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(fillColor, NSString*)

- (__kindof UIView *)view {
    return [[JZHPulseLoaderView alloc] init];
}

@end
