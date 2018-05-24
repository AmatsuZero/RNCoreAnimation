//
//  JZHProfileButton.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/22.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface JZHProfileButton : UIButton
// RCTBubblingEventBlock命名需要以onXX开头
@property(nonatomic, copy, nullable)RCTBubblingEventBlock onClick;
@property(nonatomic, copy, nonnull)NSString* title;

- (void)animation;

@end
