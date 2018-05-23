//
//  JZHSpriteRender.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZHViewTexture.h"
#import "JZHSprite.h"

@interface JZHSpriteRender : NSObject

- (instancetype)initWithTexture:(JZHViewTexture*)texture effect:(GLKBaseEffect*)effect;

- (void)render:(NSArray<JZHSprite*>*)sprites;

@end
