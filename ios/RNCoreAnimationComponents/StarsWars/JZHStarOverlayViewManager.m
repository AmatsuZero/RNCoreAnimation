//
//  JZHStarOverlayViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/22.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHStarOverlayViewManager.h"
#import "JZHStarOverlayView.h"

@implementation JZHStarOverlayViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(emitImage, NSString*)

- (UIView *)view {
    return [[JZHStarOverlayView alloc] init];
}

@end
