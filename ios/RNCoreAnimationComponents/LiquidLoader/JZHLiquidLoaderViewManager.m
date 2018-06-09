//
//  JZHLiquidLoaderViewManager.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/9.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHLiquidLoaderViewManager.h"
#import "JZHLiquidLoader.h"

@implementation JZHLiquidLoaderViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(effect, NSDictionary*)

- (__kindof UIView *)view {
    return [[JZHLiquidLoader alloc] init];
}

@end
