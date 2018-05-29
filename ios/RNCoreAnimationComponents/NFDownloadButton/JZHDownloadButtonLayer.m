//
//  JZHDownloadButtonLayer.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHDownloadButtonLayer.h"

@implementation JZHDownloadButtonLayer

- (instancetype)init {
    if (self = [super init]) {
        _toDownloadManipulable = 0;
        _rippleManipulable = 0;
        _dashMoveManipulable = 0;
        _readyToDownloadManipulable = 0;
        _downloadedManipulable = 0;
        _checkReveralManipulable = 0;
    }
    return self;
}

- (instancetype)initWithLayer:(JZHDownloadButtonLayer*)layer {
    if (self = [super initWithLayer:layer]) {
        if (layer && [layer isKindOfClass:[JZHDownloadButtonLayer class]]) {
            _toDownloadManipulable = layer.toDownloadManipulable;
            _rippleManipulable = layer.rippleManipulable;
            _dashMoveManipulable = layer.dashMoveManipulable;
            _readyToDownloadManipulable = layer.readyToDownloadManipulable;
            _downloadedManipulable = layer.downloadedManipulable;
            _checkReveralManipulable = layer.checkReveralManipulable;
        }
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if (!key) {
        return NO;
    }
    if ([JZHDownloadButtonLayer isCompatible:key]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)event {
    if (!event) {
        return nil;
    }
    if ([JZHDownloadButtonLayer isCompatible:event]) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = [[self presentationLayer] valueForKey:event];
        return animation;
    }
    return [super actionForKey:event];
}

+ (BOOL) isCompatible:(NSString*)key {
    return [key isEqualToString:@"toDownloadManipulable"] || [key isEqualToString:@"rippleManipulable"] || [key isEqualToString:@"dashMoveManipulable"]
    || [key isEqualToString:@"readyToDownloadManipulable"] || [key isEqualToString:@"downloadedManipulable"] || [key isEqualToString:@"checkRevealManipulable"];
}

@end
