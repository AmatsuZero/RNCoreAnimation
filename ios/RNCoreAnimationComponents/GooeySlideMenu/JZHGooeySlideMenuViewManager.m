//
//  JZHGooeySlideMenuViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "JZHGooeySlideMenuViewManager.h"
#import "JZHGooeySlideMenu.h"
#import "RCTConvert+SlideMenu.h"

@implementation JZHGooeySlideMenuViewManager

RCT_EXPORT_MODULE()
RCT_CUSTOM_VIEW_PROPERTY(titles, NSArray<NSString*>*, JZHGooeySlideMenu)
{
    [view setTitles:[RCTConvert menuTitles:json]];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString*)
RCT_EXPORT_VIEW_PROPERTY(buttonSpace, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(menuBlankWidth, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(buttonHeight, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(menuClickBlock, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(style, UIBlurEffectStyle)

RCT_EXPORT_METHOD(trigger:(NSNumber *)reactTag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        JZHGooeySlideMenu* menu = [self getViewWithTag:reactTag];
        [menu trigger];
    });
}

- (UIView *)view {
    return [[JZHGooeySlideMenu alloc] init];
}

/// 拿到当前View
- (JZHGooeySlideMenu *) getViewWithTag:(NSNumber *)tag {
    UIView *view = [self.bridge.uiManager viewForReactTag:tag];
    return [view isKindOfClass:[JZHGooeySlideMenu class]] ? (JZHGooeySlideMenu *)view : nil;
}

- (NSDictionary *)constantsToExport {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"blurEffectStyleExtraLight": @(UIBlurEffectStyleExtraLight),
                                                                                @"blurEffectStyleLight": @(UIBlurEffectStyleLight),
                                                                                @"blurEffectStyleDark": @(UIBlurEffectStyleDark),
                                                                                }];
    if (@available(iOS 10.0, *)) {
        dict[@"blurEffectStyleProminent"] = @(UIBlurEffectStyleProminent);
        dict[@"blurEffectStyleRegular"] = @(UIBlurEffectStyleRegular);
    }
    return [dict copy];
}

@end
