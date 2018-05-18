//
//  JZHJumpStar.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/18.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHJumpStar : UIView

@property(nonatomic, assign, getter=isMark)BOOL mark;
@property(nonatomic, copy)NSString* topImage;
@property(nonatomic, copy)NSString* backImage;

-(void)animate;

@end
