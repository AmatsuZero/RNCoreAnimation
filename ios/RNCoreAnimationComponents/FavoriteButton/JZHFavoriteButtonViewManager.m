//
//  JZHDOFavoriteButtonViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/28.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHFavoriteButtonViewManager.h"
#import "JZHFavoriteButton.h"

@implementation JZHFavoriteButtonViewManager

RCT_EXPORT_MODULE(JZHFavoriteButton)
RCT_EXPORT_VIEW_PROPERTY(image, NSString*)
RCT_EXPORT_VIEW_PROPERTY(imageColorOn, NSString*)
RCT_EXPORT_VIEW_PROPERTY(imageColorOff, NSString*)
RCT_EXPORT_VIEW_PROPERTY(circleColor, NSString*)
RCT_EXPORT_VIEW_PROPERTY(lineColor, NSString*)
RCT_EXPORT_VIEW_PROPERTY(duration, NSTimeInterval)
RCT_EXPORT_VIEW_PROPERTY(onSelect, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDeselect, RCTBubblingEventBlock)

- (UIView *)view {
    JZHFavoriteButton* button = [[JZHFavoriteButton alloc] initWithFrame:CGRectZero];
    [button addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)tappedButton:(JZHFavoriteButton*)sender {
    if (sender.isSelected)
        [sender deselect];
    else
        [sender select];
}

@end
