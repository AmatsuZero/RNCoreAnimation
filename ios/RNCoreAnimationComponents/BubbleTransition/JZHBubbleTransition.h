//
//  JZHBubbleTransition.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, JZHBubbleTransitionMode) {
    Present,
    Dismiss
};

@interface JZHBubbleTransition : NSObject<UIViewControllerAnimatedTransitioning>
/**
 *  The duration of transition
 */
@property(nonatomic,assign)CGFloat duration;
/**
 *  The startPoint of transition
 */
@property(nonatomic,assign)CGPoint startPoint;
/**
 *  Mode:Present/Dismiss
 */
@property(nonatomic,assign)JZHBubbleTransitionMode transitionMode;
/**
 *  The color of the bubble
 */
@property(nonatomic,strong)UIColor *bubbleColor;

@end
