//
//  UIColor+JZHColorExtensions.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/8.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JZHColorExtensions)

+ (instancetype)colorWithHexString:(NSString*)hexString;

+ (instancetype)colorWithHex:(unsigned int)hex useAlpha:(BOOL)useAlpha;

@end
