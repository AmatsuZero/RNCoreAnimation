//
//  JZHCardViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHCardViewManager.h"
#import "JZHCardView.h"

@implementation JZHCardViewManager

RCT_EXPORT_VIEW_PROPERTY(cardImageName, NSString*)
RCT_EXPORT_VIEW_PROPERTY(cardParallaxImageName, NSString*)
RCT_EXPORT_MODULE()
-(UIView *)view {
    return [[JZHCardView alloc] init];
}


@end
