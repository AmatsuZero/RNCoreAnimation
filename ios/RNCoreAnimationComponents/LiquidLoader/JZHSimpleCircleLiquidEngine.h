//
//  JZHSimpleCircleLiquidEngine.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZHLiquittableCircle.h"

@interface JZHSimpleCircleLiquidEngine : NSObject

@property(nonatomic, assign, readonly)CGFloat radiusTresh;
@property(nonatomic, assign, readonly)CGFloat connectTresh;
@property(nonatomic, assign)CGFloat angleThresh;
@property(nonatomic, strong)UIColor* color;

- (instancetype)initWithRaiusThresh:(CGFloat)radius angleTresh:(CGFloat)angle NS_DESIGNATED_INITIALIZER;

- (NSArray<JZHLiquittableCircle*>*)push:(JZHLiquittableCircle*)circle
                                  other:(JZHLiquittableCircle*)other;

- (void)draw:(UIView*)parent;

- (void)clear;

- (__kindof CALayer*)construct:(UIBezierPath*)path;

- (BOOL)isConnected:(JZHLiquittableCircle*)circle other:(JZHLiquittableCircle*)other;

@end
