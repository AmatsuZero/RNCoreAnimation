//
//  JZHNFDownloadButton.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHNFDownloadButton.h"
#import "NSString+JZHColorConvertor.h"
#import "JZHPalette.h"
#import "JZHDownloadButtonLayer.h"
#import "JZHStyleKit.h"

NSString* const checkRevealManipulable =  @"checkRevealManipulable";
NSString* const toDownloadManipulable = @"toDownloadManipulable";
NSString* const rippleManipulable = @"rippleManipulable";
NSString* const dashMoveManipulable = @"dashMoveManipulable";
NSString* const readyToDownloadManipulable = @"readyToDownloadManipulable";
NSString* const downloadedManipulable = @"downloadedManipulable";

@interface Flow: NSObject

+(void)async:(void(^)(void))block;

+(void)delayFor:(NSTimeInterval)delay block:(void(^)(void))block;

@end

@implementation Flow

+(void)async:(void(^)(void))block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+(void)delayFor:(NSTimeInterval)delay block:(void (^)(void))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

@end

@interface JZHNFDownloadButton()<CAAnimationDelegate>

@end

@implementation JZHNFDownloadButton {
    NSString* keyPath;
    JZHPalette* palette;
}

+ (Class)layerClass {
    return [JZHDownloadButtonLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        keyPath = @"toDownloadManipulable";
        palette = [[JZHPalette alloc] init];
        [self draw];
    }
    return self;
}

- (void)setDownloaded:(BOOL)downloaded {
    _downloaded = downloaded;
    if (downloaded) {
        [self animate:0 delay:0 from:0 to:1 keyPath:downloadedManipulable];
        [self animate:0 delay:0 from:0 to:1 keyPath:checkRevealManipulable];
    }
}

- (void)setButtonBackgroundColor:(NSString *)buttonBackgroundColor {
    _buttonBackgroundColor = [buttonBackgroundColor copy];
    palette.buttonBackgroundColor = [buttonBackgroundColor hexToColor] ?: palette.buttonBackgroundColor;
}

- (void)setInitialColor:(NSString *)initialColor {
    _initialColor = [initialColor copy];
    palette.initialColor = [initialColor hexToColor] ?: palette.initialColor;
}

- (void)setRippleColor:(NSString *)rippleColor {
    _rippleColor = [rippleColor copy];
    palette.rippleColor = [rippleColor hexToColor] ?: palette.rippleColor;
}

- (void)setDownloadColor:(NSString *)downloadColor {
    _downloadColor = [downloadColor copy];
    palette.downloadColor = [downloadColor hexToColor] ?: palette.downloadColor;
}

- (void)setDeviceColor:(NSString *)deviceColor {
    _deviceColor = [deviceColor copy];
    palette.deviceColor = [deviceColor hexToColor] ?: palette.deviceColor;
}

- (void)setDownloadPercent:(CGFloat)downloadPercent {
    JZHDownloadButtonLayer* layer = (JZHDownloadButtonLayer*)self.layer;
    if (downloadPercent >= 1.0) {
        __weak typeof(self) weakSelf= self;
        [Flow delayFor:0.5 block:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                strongSelf.downloadPercent = downloaded;
                layer.readyToDownloadManipulable = 0.0;
            }
        }];
    }
    [self animate:0.5 delay:0 from:layer.readyToDownloadManipulable to:downloadPercent keyPath:readyToDownloadManipulable];
    _downloadPercent = downloadPercent;
}

- (void)setDownloadState:(JZHDownloadButtonState)downloadState {
    if (!self.isDownloaded) {
        switch (downloadState) {
            case toDownload: {
                [self resetManipulabes];
                [Flow async:^{
                    [self animate:0 delay:0 from:0 to:1 keyPath: toDownloadManipulable];
                }];
            }
                break;
            case willDownload: {
                [Flow async:^{
                    [self animate:1 delay:0 from:0 to:1 keyPath:rippleManipulable];
                }];
            }
                break;
            case readyToDownload: {
                [Flow async:^{
                    [self animate:0 delay:0 from:0 to:0 keyPath:readyToDownloadManipulable];
                }];
            }
                break;
            case downloaded: {
                [Flow async:^{
                    [self animate:1 delay:0 from:0 to:1 keyPath:downloadedManipulable];
                }];
            }
                break;
            default:
                break;
        }
    }
}

- (void)resetManipulabes {
    JZHDownloadButtonLayer* layer = (JZHDownloadButtonLayer*)self.layer;
    layer.toDownloadManipulable = 0;
    layer.rippleManipulable = 0;
    layer.dashMoveManipulable = 0;
    layer.readyToDownloadManipulable = 0;
    layer.downloadedManipulable = 0;
    layer.checkReveralManipulable = 0;
}

- (void)draw {
    self.downloadState = _downloadState;
    [self needsDisplay];
}

- (void)needsDisplay {
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer setNeedsDisplay];
}

- (void) animate:(NSTimeInterval)duration delay:(NSTimeInterval)delay from:(CGFloat)from to:(CGFloat)to keyPath:(NSString*)keyPath {
    JZHDownloadButtonLayer* layer = (JZHDownloadButtonLayer*)self.layer;
    self->keyPath = keyPath;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.duration = duration;
    animation.fillMode = kCAFillModeBoth;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.fromValue = @(from);
    animation.toValue = @(to);
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];
    [Flow async:^{
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self updateManipulable:layer keyPath:keyPath value:to];
        [CATransaction commit];
    }];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
    JZHDownloadButtonLayer* d_layer = (JZHDownloadButtonLayer*)self.layer;

    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(d_layer.frame), CGRectGetHeight(d_layer.frame));

    UIGraphicsPushContext(ctx);
    if ([keyPath isEqualToString:toDownloadManipulable]) {
        [JZHStyleKit drawToDownloadState:frame resizing:[JZHResizingBehavior aspectFit] palette:palette toDownloadManipulable:d_layer.toDownloadManipulable];
    } else if ([keyPath isEqualToString:rippleManipulable]) {
        [JZHStyleKit drawRippleState:frame resizing:[JZHResizingBehavior aspectFit] palette:palette rippleManipulable:d_layer.rippleManipulable];
    } else if ([keyPath isEqualToString:dashMoveManipulable]) {
        [JZHStyleKit drawDashMoveState:frame resizing:[JZHResizingBehavior aspectFit] palette:palette dashMoveManipulable:d_layer.dashMoveManipulable];
    } else if ([keyPath isEqualToString:readyToDownloadManipulable]) {
        [JZHStyleKit drawReadyToDownloadState:frame resizing:[JZHResizingBehavior aspectFit] palette:palette readyToDownloadManipulable:d_layer.readyToDownloadManipulable];
    } else if ([keyPath isEqualToString:downloadedManipulable]) {
        [JZHStyleKit drawDownloadCompleteState:frame resizing:[JZHResizingBehavior aspectFit] palette:palette downloadedManipulable:d_layer.downloadedManipulable];
    } else if ([keyPath isEqualToString:checkRevealManipulable]) {
        [JZHStyleKit drawCheckState:frame resizing:[JZHResizingBehavior aspectFit] palette:palette downloadedManipulable:0 checkRevealManipulable:d_layer.checkReveralManipulable];
    }
    UIGraphicsPopContext();
}

- (void)updateManipulable:(JZHDownloadButtonLayer*)layer keyPath:(NSString*)keyPath value:(CGFloat)value {
    if ([keyPath isEqualToString:toDownloadManipulable]) {
        layer.toDownloadManipulable = value;
    } else if ([keyPath isEqualToString:rippleManipulable]) {
        layer.rippleManipulable = value;
    } else if ([keyPath isEqualToString:dashMoveManipulable]) {
        layer.dashMoveManipulable = value;
    } else if ([keyPath isEqualToString:readyToDownloadManipulable]) {
        layer.readyToDownloadManipulable = value;
    } else if ([keyPath isEqualToString:downloadedManipulable]) {
        layer.downloadedManipulable = value;
    } else if ([keyPath isEqualToString:checkRevealManipulable]) {
        layer.checkReveralManipulable = value;
    }
}

#pragma mark - CAAnimation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString* keypath = [(CABasicAnimation*)anim keyPath];
    if ([keypath isEqualToString:rippleManipulable]) {
        [self animate:1 delay:0 from:0 to:1 keyPath:dashMoveManipulable];
    } else if ([keypath isEqualToString:downloadedManipulable]) {
        if (!self.isDownloaded) {
            [self animate:0.5 delay:0 from:0 to:1 keyPath:checkRevealManipulable];
        }
    }
    if ([keypath isEqualToString:toDownloadManipulable] && self.onNewState) {
        self.onNewState(@{@"state": @"toDownload"});
    } else if ([keypath isEqualToString:rippleManipulable] && self.onNewState) {
        self.onNewState(@{@"state": @"willDownload"});
    } else if ([keypath isEqualToString:dashMoveManipulable] && self.onNewState) {
        self.onNewState(@{@"state": @"readyToDownload"});
    } else if ([keypath isEqualToString:checkRevealManipulable] && self.onNewState) {
        self.onNewState(@{@"state": @"downloaded"});
    }
}

@end
