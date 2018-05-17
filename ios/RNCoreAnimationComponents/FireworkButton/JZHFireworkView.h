//
//  JZHFireworkView.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHFireworkView : UIView

@property (strong, nonatomic)UIImage *particleImage;
@property (assign, nonatomic)CGFloat particleScale;
@property (assign, nonatomic)CGFloat particleScaleRange;

- (void)animate;

@end
