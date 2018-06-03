//
//  JZHLiquittableCircle.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHLiquittableCircle : UIView

@property(nonatomic, strong, nonnull)NSMutableArray<NSValue*>* points;
@property(nonatomic, assign, getter=isGrow)BOOL grow;
@property(nonatomic, assign)CGFloat radius;
@property(nonatomic, strong, nonnull)UIColor* color;
@property(nonatomic, strong, nonnull)UIColor* growColor;

- (void)move:(CGPoint)dt;

- (void)draw:(UIBezierPath* _Nonnull)path;

- (void)grow:(BOOL)isGrow;

- (CGPoint)circlePoint: (CGFloat)rad;

- (instancetype)initWithCenter:(CGPoint)center
                        radius:(CGFloat)radius
                         color:(UIColor* _Nonnull)color
                     growColor:(UIColor* _Nullable)gColor;

@end
