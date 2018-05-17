//
//  JZHInteractiveTransition.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic,assign, getter=isInteracting)BOOL interacting;

-(void) addPopGesture:(UIViewController *)viewController;

@end
