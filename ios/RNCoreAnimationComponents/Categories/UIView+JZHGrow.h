//
//  UIColor+JZHGrow.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JZHGrow)

- (void)growWithBaseColor:(UIColor*)baseColor
                   radius:(CGFloat)radius
                shininess:(CGFloat)shininess;

- (void)growShadowWithColor:(UIColor*)growColor
                     radius:(CGFloat)radius
                  shininess:(CGFloat)shininess;

@end
