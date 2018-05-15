//
//  RCTConvert+SlideMenu.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "RCTConvert+SlideMenu.h"

@implementation RCTConvert (SlideMenu)

RCT_ENUM_CONVERTER(UIBlurEffectStyle,
                   (blurStyle()),
                   UIBlurEffectStyleDark,
                   integerValue)

+(NSArray<NSString*>*)menuTitles: (id)json {
    json = [self NSArray:json];
    return json;
}

@end
