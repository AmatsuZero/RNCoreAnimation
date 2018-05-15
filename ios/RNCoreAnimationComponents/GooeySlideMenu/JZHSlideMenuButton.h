//
//  JZHSlideMenuButton.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHSlideMenuButton : UIView
/**
 *  The button color
 */
@property(nonatomic,strong)UIColor *buttonColor;

/**
 *  button clicked block
 */
@property(nonatomic,copy)void(^buttonClickBlock)(void);

- (instancetype)initWithTitle:(NSString*)title;

@end
