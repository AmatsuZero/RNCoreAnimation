//
//  RCTViewManager+JZHTagManager.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/5.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <React/RCTViewManager.h>

@interface RCTViewManager (JZHTagManager)

@property(nonatomic, strong, class)NSMapTable<NSString*,__kindof UIView*>* viewTagMap;

@end
