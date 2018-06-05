//
//  RCTViewManager+JZHTagManager.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/5.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "RCTViewManager+JZHTagManager.h"

static NSString* const KEY = @"viewTagMap";

@implementation RCTViewManager (JZHTagManager)

static NSMapTable* table;

+ (NSMapTable<NSString *,__kindof UIView *> *)viewTagMap {
    return table;
}

+ (void)setViewTagMap:(NSMapTable<NSString *,__kindof UIView *> *)viewTagMap {
    table = viewTagMap;
}

RCT_EXPORT_METHOD(tagView:(NSNumber* _Nullable)viewTag withTag:(NSString*)tag) {
    UIView *view = [self.bridge.uiManager viewForReactTag:viewTag];
    if (![RCTViewManager viewTagMap]) {
        [RCTViewManager setViewTagMap:[NSMapTable weakToWeakObjectsMapTable]];
    }
    [[RCTViewManager viewTagMap] setObject:view forKey:tag];
}

@end
