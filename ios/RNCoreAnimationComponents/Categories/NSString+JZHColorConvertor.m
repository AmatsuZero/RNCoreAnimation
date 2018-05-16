//
//  NSString+JZHColorConvertor.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/16.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import "NSString+JZHColorConvertor.h"

@implementation NSString (JZHColorConvertor)

- (UIColor *)hexToColor {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setScanLocation:1]; // bypass '#' character
    if (![scanner scanHexInt:&rgbValue]) return nil;
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:1.0];
}

@end
