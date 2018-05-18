//
//  JZHDynamicCoverViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "JZHDynamicCoverViewManager.h"
#import "JZHDynamicCover.h"

@implementation JZHDynamicCoverViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(restore:(NSNumber* _Nonnull)tag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        JZHDynamicCover *view = (JZHDynamicCover*)[self.bridge.uiManager viewForReactTag:tag];
        [view restore];
    });
}

- (__kindof UIView *)view {
    return [[JZHDynamicCover alloc] init];
}


@end
