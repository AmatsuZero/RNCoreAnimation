//
//  JZHGooeySlideMenuViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHGooeySlideMenuViewManager.h"
#import "JZHGooeySlideMenu.h"
#import "RCTConvert+SlideMenu.h"

@implementation JZHGooeySlideMenuViewManager
{
    JZHGooeySlideMenu* menu;
}

RCT_EXPORT_MODULE()
RCT_CUSTOM_VIEW_PROPERTY(titles, NSArray<NSString*>*, JZHGooeySlideMenu)
{
    [menu setTitles:[RCTConvert menuTitles:json]];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString*)
RCT_EXPORT_VIEW_PROPERTY(buttonSpace, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(menuBlankWidth, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(buttonHeight, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(menuClickBlock, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(style, UIBlurEffectStyle)

RCT_EXPORT_METHOD(trigger) {
    [menu trigger];
}

- (UIView *)view {
    if (!menu) {
        menu = [[JZHGooeySlideMenu alloc] init];
    }
    return menu;
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
