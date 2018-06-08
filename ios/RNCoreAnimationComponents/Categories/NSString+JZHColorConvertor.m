//
//  NSString+JZHColorConvertor.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/16.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import "NSString+JZHColorConvertor.h"
#import "UIColor+JZHColorExtensions.h"

@implementation NSString (JZHColorConvertor)

- (UIColor *)hexToColor {
    return [UIColor colorWithHexString:self];
}

@end
