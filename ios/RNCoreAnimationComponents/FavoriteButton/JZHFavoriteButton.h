//
//  JZHFavoriteButton.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/28.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface JZHFavoriteButton : UIButton

@property(nonatomic, copy)NSString* image;
@property(nonatomic, copy)NSString* imageColorOn;
@property(nonatomic, copy)NSString* imageColorOff;
@property(nonatomic, copy)NSString* circleColor;
@property(nonatomic, copy)NSString* lineColor;
@property(nonatomic, assign)NSTimeInterval duration;

@property(nonatomic, copy, nullable)RCTBubblingEventBlock onSelect;
@property(nonatomic, copy, nullable)RCTBubblingEventBlock onDeselect;

- (void)select;
- (void)deselect;

@end
