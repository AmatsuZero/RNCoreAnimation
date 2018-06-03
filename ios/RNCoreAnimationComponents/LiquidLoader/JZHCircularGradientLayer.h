//
//  JZHCircularGradientLayer.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface JZHCircularGradientLayer : CALayer

@property(nonatomic, strong, readonly)NSArray<UIColor*>* colors;

- (instancetype)initWithColors:(NSArray<UIColor*>*)colors NS_DESIGNATED_INITIALIZER;

@end
