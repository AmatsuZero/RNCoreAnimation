//
//  JZHModalTransitionDelegate.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHModalTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

+(_Nullable instancetype)modalDelegateForTag:(NSNumber* _Nonnull)tag;

+(_Nonnull instancetype)addModalDelegaetForTag:(NSNumber* _Nonnull)tag;

@end
