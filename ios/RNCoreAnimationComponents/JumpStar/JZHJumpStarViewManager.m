//
//  JZHJumpStarViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/18.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "JZHJumpStarViewManager.h"
#import "JZHJumpStar.h"

@implementation JZHJumpStarViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(mark, BOOL)
RCT_EXPORT_VIEW_PROPERTY(topImage, NSString*)
RCT_EXPORT_VIEW_PROPERTY(backImage, NSString*)
RCT_EXPORT_METHOD(flip:(NSNumber* _Nonnull)tag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        JZHJumpStar *view = (JZHJumpStar*)[self.bridge.uiManager viewForReactTag:tag];
        [view animate];
    });
}

- (__kindof UIView *)view {
    return [[JZHJumpStar alloc] init];
}

@end
