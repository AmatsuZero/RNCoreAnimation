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

@property(nonatomic, copy, nullable)RCTBubblingEventBlock clickEvent;
@property(nonatomic, copy, nonnull)NSString* title;

- (void)animation;

@end
