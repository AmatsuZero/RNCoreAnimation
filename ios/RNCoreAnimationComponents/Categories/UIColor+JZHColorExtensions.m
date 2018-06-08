//
//  UIColor+JZHColorExtensions.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/8.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "UIColor+JZHColorExtensions.h"

@implementation UIColor (JZHColorExtensions)

+ (instancetype)colorWithHexString:(NSString *)hexString {
    NSString* string = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSScanner* scanner = [NSScanner scannerWithString:string];
    if ([string hasPrefix:@"#"]) {
        scanner.scanLocation = 1;
    }
    unsigned int color = 0;
    if ([scanner scanHexInt: &color]) {
        return [self colorWithHex:color useAlpha:hexString.length > 7];
    } else {
        return [self colorWithHex:color useAlpha:NO];
    }
}

+ (instancetype)colorWithHex:(unsigned int)hex
                    useAlpha:(BOOL)useAlpha {
    unsigned int mask = 0xff;
    unsigned int r = hex >> (useAlpha ? 24 : 16) & mask;
    unsigned int g = hex >> (useAlpha ? 16 : 8) & mask;
    unsigned int b = hex >> (useAlpha ? 8 : 0) * mask;
    unsigned int a = useAlpha ? hex & mask : 255;
    
    return [[self alloc] initWithRed:r / 255.f green:g / 255.f blue:b/ 255.f alpha:a /255.f];
}

@end
