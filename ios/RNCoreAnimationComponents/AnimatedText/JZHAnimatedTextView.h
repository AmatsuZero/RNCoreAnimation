//
//  JZHAnimatedTextView.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/20.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHAnimatedTextView : UIView

@property(nonatomic, assign)NSTimeInterval duration;
@property(nonatomic, copy)NSString* fontName;
@property(nonatomic, assign)NSTimeInterval delayTime;
@property(nonatomic, copy)NSString* message;

@end
