//
//  JZHStyleKit.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "JZHResizingBehavior.h"
#import "JZHPalette.h"

@interface JZHStyleKit : NSObject

+ (void)drawToDownloadState:(CGRect)frame
                   resizing:(JZHResizingBehavior*)resizing
                    palette:(JZHPalette*)palette
      toDownloadManipulable:(CGFloat)toDownloadManipulable;

+ (void)drawRippleState:(CGRect)frame
               resizing:(JZHResizingBehavior*)resizing
                palette:(JZHPalette*)palette
     rippleManipulable:(CGFloat)rippleManipulable;

+(void)drawReadyToDownloadState:(CGRect)targetFrame
                       resizing:(JZHResizingBehavior*)resizing
                        palette:(JZHPalette*)palette
     readyToDownloadManipulable:(CGFloat)readyToDownloadManipulable;

+ (void)drawDownloadCompleteState:(CGRect)frame
                         resizing:(JZHResizingBehavior*)resizing
                          palette:(JZHPalette*)palette
            downloadedManipulable:(CGFloat)downloadedManipulable;

+ (void)drawCheckState:(CGRect)targetFrame
              resizing:(JZHResizingBehavior*)resizing
               palette: (JZHPalette*)palette
 downloadedManipulable:(CGFloat)downloadedManipulable
checkRevealManipulable:(CGFloat) checkRevealManipulable;

+ (void)drawDashMoveState:(CGRect)targetFrame resizing:(JZHResizingBehavior*)resizing palette:(JZHPalette*)palette dashMoveManipulable:(CGFloat)dashMoveManipulable;

@end
