//
//  JZHDrawingboardViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/21.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "JZHDrawingboardViewManager.h"
#import "JZHDrawingboardView.h"

@implementation JZHDrawingboardViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(color, NSString*)

RCT_EXPORT_METHOD(play:(NSNumber* _Nonnull)tag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getViewWithTag:tag] playView];
    });
}

RCT_EXPORT_METHOD(undo:(NSNumber* _Nonnull)tag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getViewWithTag:tag] back];
    });
}

RCT_EXPORT_METHOD(clear:(NSNumber* _Nonnull)tag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getViewWithTag:tag] clear];
    });
}

RCT_EXPORT_METHOD(capture:(NSNumber* _Nonnull)tag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getViewWithTag:tag] capture];
    });
}

RCT_EXPORT_METHOD(playDemo:(NSNumber* _Nonnull)tag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getViewWithTag:tag] playDemo];
    });
}

- (__kindof UIView *)view {
    return [[JZHDrawingboardView alloc] init];
}

/// 拿到当前View
- (JZHDrawingboardView * _Nullable) getViewWithTag:(NSNumber * _Nonnull)tag {
    UIView *view = [self.bridge.uiManager viewForReactTag:tag];
    return [view isKindOfClass:[JZHDrawingboardView class]] ? (JZHDrawingboardView *)view : nil;
}


@end
