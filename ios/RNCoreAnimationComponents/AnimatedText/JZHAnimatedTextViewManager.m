//
//  JZHAnimatedViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/20.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHAnimatedTextViewManager.h"
#import "JZHAnimatedTextView.h"

@implementation JZHAnimatedTextViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(duration, NSTimeInterval)
RCT_EXPORT_VIEW_PROPERTY(fontName, NSString*)
RCT_EXPORT_VIEW_PROPERTY(delayTime, NSTimeInterval)
RCT_EXPORT_VIEW_PROPERTY(message, NSString*)

- (__kindof UIView *)view {
    return [[JZHAnimatedTextView alloc] init];
}

@end
