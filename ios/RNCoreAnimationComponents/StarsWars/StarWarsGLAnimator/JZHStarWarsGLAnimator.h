//
//  JZHStarWarsGLAnimator.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface JZHStarWarsGLAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)NSTimeInterval duration;
@property(nonatomic, assign)CGFloat spriteWidth;

@end
