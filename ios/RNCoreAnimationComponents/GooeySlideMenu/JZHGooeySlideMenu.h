//
//  JZHGooeySlideMenu.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface JZHGooeySlideMenu : UIView

@property(nonatomic, strong)NSArray<NSString*>* titles;
@property(nonatomic, copy)NSString* color;
@property(nonatomic, assign)UIBlurEffectStyle style;
@property(nonatomic, assign)CGFloat buttonSpace;
@property(nonatomic, assign)CGFloat menuBlankWidth;
@property(nonatomic, assign)CGFloat buttonHeight;
/**
 *  The block of menu buttons cliced
 */
@property(nonatomic,copy)RCTBubblingEventBlock menuClickBlock;
/**
 *  Method to trigger the animation
 */
-(void)trigger;


@end
