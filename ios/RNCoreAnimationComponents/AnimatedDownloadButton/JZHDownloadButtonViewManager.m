//
//  JZHDownloadButtonViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/16.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHDownloadButtonViewManager.h"
#import "JZHAnimatedDownloadButton.h"

@implementation JZHDownloadButtonViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(progressBarHeight, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(progressBarWidth, CGFloat)

- (UIView *)view {
    return [[JZHAnimatedDownloadButton alloc] init];
}

@end
