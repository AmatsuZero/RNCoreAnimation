//
//  JZHFireworkButtonViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHFireworkButtonViewManager.h"
#import "JZHFireworkButton.h"

@implementation JZHFireworkButtonViewManager

RCT_EXPORT_MODULE(JZHFireworkButton)
RCT_EXPORT_VIEW_PROPERTY(particleImageName, NSString*)
RCT_EXPORT_VIEW_PROPERTY(particleScale, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(particleScaleRange, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(activeImageName, NSString*)
RCT_EXPORT_VIEW_PROPERTY(inactiveImageName, NSString*)
RCT_EXPORT_VIEW_PROPERTY(activeCallback, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(disactiveCallback, RCTBubblingEventBlock)

- (UIView *)view {
    JZHFireworkButton* btn = [[JZHFireworkButton alloc] init];
    [btn addTarget:self action:@selector(handlePress:) forControlEvents: UIControlEventTouchUpInside];
    return btn;
}

- (void)handlePress:(JZHFireworkButton*)sender {
    sender.selected = !sender.selected;
}

@end
