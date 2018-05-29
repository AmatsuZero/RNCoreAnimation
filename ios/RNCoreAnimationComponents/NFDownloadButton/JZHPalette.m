//
//  JZHPalette.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHPalette.h"

@implementation JZHPalette

- (instancetype)init {
    if (self = [super init]) {
        _initialColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        _rippleColor = [UIColor colorWithRed:0.572 green:0.572 blue:0.572 alpha:1];
        _buttonBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _downloadColor = [UIColor colorWithRed:0.145 green:0.439 blue:0.733 alpha:1];
        _deviceColor = [UIColor colorWithRed:0.145 green:0.439 blue:0.733 alpha:1];
    }
    return self;
}

@end
