//
//  JZHUViewAnimator.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/28.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHUViewAnimator : NSObject<UIViewControllerInteractiveTransitioning>

@property(assign, nonatomic)NSTimeInterval duration;
@property(assign, nonatomic)CGFloat spriteWidth;

@end
