//
//  JZHResizingBehavior.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ResizingBehavior) {
    aspectFit = 0,
    aspectFill,
    stretch,
    center
};

__attribute__((objc_subclassing_restricted)) // 相当于Final
@interface JZHResizingBehavior : NSObject

@property(nonatomic, strong, class, readonly)JZHResizingBehavior* aspectFit;
@property(nonatomic, strong, class, readonly)JZHResizingBehavior* aspectFill;
@property(nonatomic, strong, class, readonly)JZHResizingBehavior* stretch;
@property(nonatomic, strong, class, readonly)JZHResizingBehavior* center;

@property(nonatomic, assign, readonly)ResizingBehavior rawValue;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

- (CGRect)apply:(CGRect)rect to:(CGRect)target;

@end
