//
//  JZHProfileButtonViewManager.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/22.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHProfileButtonViewManager.h"
#import "JZHProfileButton.h"

@implementation JZHProfileButtonViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(onClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(title, NSString*)

- (UIView *)view {
    JZHProfileButton* btn = [[JZHProfileButton alloc] init];
    [btn addTarget:self
            action:@selector(onSelect:)
  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)onSelect:(JZHProfileButton*)sender {
    [sender animation];
}

@end
