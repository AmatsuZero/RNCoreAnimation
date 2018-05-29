//
//  JZHNFDownloadButton.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHNFDownloadButton.h"

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

@implementation JZHNFDownloadButton

@end
