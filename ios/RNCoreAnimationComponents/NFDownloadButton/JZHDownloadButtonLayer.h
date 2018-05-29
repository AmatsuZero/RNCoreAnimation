//
//  JZHDownloadButtonLayer.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface JZHDownloadButtonLayer : CALayer

@property(nonatomic, assign)CGFloat toDownloadManipulable;
@property(nonatomic, assign)CGFloat rippleManipulable;
@property(nonatomic, assign)CGFloat dashMoveManipulable;
@property(nonatomic, assign)CGFloat readyToDownloadManipulable;
@property(nonatomic, assign)CGFloat downloadedManipulable;
@property(nonatomic, assign)CGFloat checkReveralManipulable;

@end
