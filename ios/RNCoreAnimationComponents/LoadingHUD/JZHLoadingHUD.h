//
//  JZHLoadingHUD.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/17.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

@interface JZHLoadingHUD : UIVisualEffectView<RCTBridgeModule>

+(void)showHUD;

+(void)dismissHUD;

@end
