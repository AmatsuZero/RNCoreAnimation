//
//  JZHLiquidLoader.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHLiquidLoader : UIView

@property(nonatomic, strong)NSDictionary<NSString*, id>* effect;

- (void)show;
- (void)hide;

@end
