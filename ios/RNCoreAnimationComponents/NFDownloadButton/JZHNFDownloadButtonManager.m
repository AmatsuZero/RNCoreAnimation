//
//  JZHNFDownloadButtonManager.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/5/30.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <React/RCTConvert.h>
#import "JZHNFDownloadButtonManager.h"
#import "JZHNFDownloadButton.h"

@implementation RCTConvert (NFDownloadState)

RCT_ENUM_CONVERTER(JZHDownloadButtonState,
  (@{
    @"toDownload": @(toDownload),
    @"willDownload": @(willDownload),
    @"readyToDownload": @(readyToDownload),
    @"downloaded": @(downloaded)
    }), toDownload, integerValue);

@end


@implementation JZHNFDownloadButtonManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(downloaded, BOOL)
RCT_EXPORT_VIEW_PROPERTY(buttonBackgroundColor, NSString*)
RCT_EXPORT_VIEW_PROPERTY(initialColor, NSString*)
RCT_EXPORT_VIEW_PROPERTY(rippleColor, NSString*)
RCT_EXPORT_VIEW_PROPERTY(downloadColor, NSString*)
RCT_EXPORT_VIEW_PROPERTY(deviceColor, NSString*)
RCT_EXPORT_VIEW_PROPERTY(downloadPercent, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(downloadState, JZHDownloadButtonState)
RCT_EXPORT_VIEW_PROPERTY(onNewState, RCTBubblingEventBlock)

- (__kindof UIView *)view {
    JZHNFDownloadButton* button = [[JZHNFDownloadButton alloc] init];
    [button addTarget:self
               action:@selector(changeState:)
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)changeState:(JZHNFDownloadButton*) sender {
    if (sender.downloadState == toDownload) {
        sender.downloadState = willDownload;
    } else if (sender.downloadState == downloaded) {
        sender.downloadState = toDownload;
    }
}

@end
