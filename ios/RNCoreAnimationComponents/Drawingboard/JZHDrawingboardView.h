//
//  JZHDrawingboardView.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/21.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHDrawingboardView : UIView

@property(nonatomic, copy)NSString* color;

- (void)clear;
- (void)playView;
- (void)back;
- (void)capture;
- (void)playDemo;

@end
