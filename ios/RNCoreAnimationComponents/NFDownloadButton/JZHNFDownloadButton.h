//
//  JZHNFDownloadButton.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

typedef NS_ENUM(NSUInteger, JZHDownloadButtonState) {
    toDownload = 0,
    willDownload,
    readyToDownload,
    downloaded
};

@interface JZHNFDownloadButton : UIButton

@property(nonatomic,assign, getter=isDownloaded)BOOL downloaded;
@property(nonatomic, copy, nullable)NSString* buttonBackgroundColor;
@property(nonatomic, copy, nullable)NSString* initialColor;
@property(nonatomic, copy, nullable)NSString* rippleColor;
@property(nonatomic, copy, nullable)NSString* downloadColor;
@property(nonatomic, copy, nullable)NSString* deviceColor;
@property(nonatomic, assign)CGFloat downloadPercent;
@property(nonatomic, assign)JZHDownloadButtonState downloadState;
@property(nonatomic, copy, nullable)RCTBubblingEventBlock onNewState;

@end
