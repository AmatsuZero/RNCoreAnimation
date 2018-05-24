//
//  JZHIDynamicAnimator.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/24.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHUIDynamicAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)NSTimeInterval duration;
@property(nonatomic, assign)CGFloat spriteWidth;

@end
