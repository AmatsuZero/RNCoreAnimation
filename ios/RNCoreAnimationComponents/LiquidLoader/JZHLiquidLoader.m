//
//  JZHLiquidLoader.m
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHLiquidLoader.h"
#import "JZHLiquidLoadEffect.h"
#import "NSString+JZHColorConvertor.h"
#import "JZHLiquidLineEffect.h"
#import "JZHLiquidCircleEffect.h"

@implementation JZHLiquidLoader {
    __kindof JZHLiquidLoadEffect* effectDelegate;
}

- (void)setEffect:(NSDictionary<NSString *,id> *)effect {
    NSString* hex = [effect[@"color"] stringValue];
    NSUInteger count = [effect[@"count"] integerValue];
    CGFloat duration = [effect[@"duration"] floatValue];
    NSString* grow = [effect[@"grow"] stringValue];
    NSString* type = [effect[@"type"] stringValue];
    if ([type isEqualToString:@"line"]) {
        effectDelegate = [[JZHLiquidLineEffect alloc] initWithLoader:self
                                                               color:[hex hexToColor]
                                                         circleCount:count
                                                            duration:duration
                                                           growColor:[grow hexToColor]];
    } else if ([type isEqualToString:@"circle"]) {
        effectDelegate = [[JZHLiquidCircleEffect alloc] initWithLoader:self
                                                                 color:[hex hexToColor]
                                                           circleCount:count
                                                              duration:duration
                                                             growColor:[grow hexToColor]];
    } else if ([type isEqualToString:@"growLine"]) {
        effectDelegate = [[JZHLiquidLineEffect alloc] initWithLoader:self
                                                               color:[hex hexToColor]
                                                         circleCount:count
                                                            duration:duration
                                                           growColor:[grow hexToColor]];
        effectDelegate.grow = YES;
    } else if ([type isEqualToString:@"growCircle"]) {
        effectDelegate = [[JZHLiquidCircleEffect alloc] initWithLoader:self
                                                                 color:[hex hexToColor]
                                                           circleCount:count
                                                              duration:duration
                                                             growColor:[grow hexToColor]];
        effectDelegate.grow = YES;
    }
}


- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}


- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (!self.window) {
        [effectDelegate stopTimer];
    }
}

@end
