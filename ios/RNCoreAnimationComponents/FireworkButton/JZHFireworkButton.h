//
//  JZHFireworkButton.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface JZHFireworkButton : UIButton

@property (copy, nonatomic)NSString *particleImageName;
@property (assign, nonatomic)CGFloat particleScale;
@property (assign, nonatomic)CGFloat particleScaleRange;
@property (copy, nonatomic)NSString* activeImageName;
@property (copy, nonatomic)NSString* inactiveImageName;

@property (nonatomic, copy, nullable)RCTBubblingEventBlock activeCallback;
@property (nonatomic, copy, nullable)RCTBubblingEventBlock disactiveCallback;


@end
