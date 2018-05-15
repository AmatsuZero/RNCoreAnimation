//
//  RCTConvert+SlideMenu.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <React/RCTConvert.h>

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

@interface RCTConvert (SlideMenu)

+(NSArray<NSString*>*)menuTitles: (id)json;


@end
