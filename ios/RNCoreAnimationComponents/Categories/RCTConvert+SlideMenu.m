//
//  RCTConvert+SlideMenu.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "RCTConvert+SlideMenu.h"

@implementation RCTConvert (SlideMenu)

NSDictionary<NSString*, NSNumber*>* blurStyle() {
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

RCT_ENUM_CONVERTER(UIBlurEffectStyle,
                   (blurStyle()),
                   UIBlurEffectStyleDark,
                   integerValue)

+(NSArray<NSString*>*)menuTitles: (id)json {
    json = [self NSArray:json];
    return json;
}

@end
