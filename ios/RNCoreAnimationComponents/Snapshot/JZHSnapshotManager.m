//
//  JZHSnapshotManager.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/5.
//  Copyright © 2018年 Daubert. All rights reserved.
//
@import WebKit;
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "JZHSnapshotManager.h"

const NSTimeInterval DELAY_TIME_DRAW = 0.1;

typedef void(^CaptureResult)(UIImage*);

@implementation JZHSnapshotManager {
    BOOL _isCapturing;
}
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()
RCT_REMAP_METHOD(snapshotForView,
                 tag:(NSString*)tag
                 path: (NSString*) path
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    
    UIView* view = [[RCTViewManager viewTagMap] objectForKey:tag];
    if (!view || self->_isCapturing) {
        return;
    }
    CaptureResult callback = ^(UIImage* image) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 保存到磁盘
            resolve(@([UIImagePNGRepresentation(image) writeToFile:path atomically:YES]));
        });
    };
    if ([view isKindOfClass:[UIScrollView class]]) {
        [self snapshotForScrollView:(UIScrollView *)view callback:callback];
    } else if ([view isKindOfClass:[UIWebView class]]) {
        UIWebView *webView = (UIWebView *)view;
        [self snapshotForScrollView:webView.scrollView callback:callback];
    } else if ([view isKindOfClass:[WKWebView class]]) {
        [self snapshotForWKWebView:(WKWebView *)view callback:callback];
    }
}

#pragma mark - WKWebView

- (void)snapshotForWKWebView:(WKWebView *)webView callback:(CaptureResult _Nullable)callback {
    UIView *snapshotView = [webView snapshotViewAfterScreenUpdates:YES];
    snapshotView.frame = webView.frame;
    [webView.superview addSubview:snapshotView];
    
    CGPoint currentOffset = webView.scrollView.contentOffset;
    CGRect currentFrame = webView.frame;
    UIView *currentSuperView = webView.superview;
    NSUInteger currentIndex = [webView.superview.subviews indexOfObject:webView];
    
    UIView *containerView = [[UIView alloc] initWithFrame:webView.bounds];
    [webView removeFromSuperview];
    [containerView addSubview:webView];
    
    CGSize totalSize = webView.scrollView.contentSize;
    NSInteger page = ceil(totalSize.height / containerView.bounds.size.height);
    
    webView.scrollView.contentOffset = CGPointZero;
    webView.frame = CGRectMake(0, 0, containerView.bounds.size.width, webView.scrollView.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(totalSize, YES, UIScreen.mainScreen.scale);
    [self drawContentPage:containerView webView:webView index:0 maxIndex:page completion:^{
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [webView removeFromSuperview];
        [currentSuperView insertSubview:webView atIndex:currentIndex];
        webView.frame = currentFrame;
        webView.scrollView.contentOffset = currentOffset;
        
        [snapshotView removeFromSuperview];
        
        self->_isCapturing = NO;
        
        if (callback) {
            callback(snapshotImage);
        }
    }];
}

- (void)drawContentPage:(UIView *)targetView webView:(WKWebView *)webView index:(NSInteger)index maxIndex:(NSInteger)maxIndex completion:(dispatch_block_t)completion {
    CGRect splitFrame = CGRectMake(0, index * CGRectGetHeight(targetView.bounds), targetView.bounds.size.width, targetView.frame.size.height);
    CGRect myFrame = webView.frame;
    myFrame.origin.y = -(index * targetView.frame.size.height);
    webView.frame = myFrame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_TIME_DRAW * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [targetView drawViewHierarchyInRect:splitFrame afterScreenUpdates:YES];
        
        if (index < maxIndex) {
            [self drawContentPage:targetView webView:webView index:index + 1 maxIndex:maxIndex completion:completion];
        } else {
            completion();
        }
    });
}

#pragma mark - UIScrollView
- (void)snapshotForScrollView:(UIScrollView *)scrollView callback:(CaptureResult _Nullable)callback {
    
    CGPoint currentOffset = scrollView.contentOffset;
    CGRect currentFrame = scrollView.frame;
    
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, UIScreen.mainScreen.scale);
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    scrollView.contentOffset = currentOffset;
    scrollView.frame = currentFrame;
    
    if (callback) {
        callback(snapshotImage);
    }
}

@end
