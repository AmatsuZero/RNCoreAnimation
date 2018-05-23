//
//  JZHSprite.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface TexturedVertex: NSObject<NSCopying>

@property(nonatomic, assign)GLKVector2 geometryVertex;
@property(nonatomic, assign)GLKVector2 textureVertex;

@end

@interface TexturedQuad: NSObject<NSCopying>

@property(nonatomic, copy)TexturedVertex* bl;
@property(nonatomic, copy)TexturedVertex* br;
@property(nonatomic, copy)TexturedVertex* tl;
@property(nonatomic, copy)TexturedVertex* tr;

@end

@interface JZHSprite : NSObject

@property(nonatomic, copy)TexturedQuad* quad;
@property(nonatomic, assign)GLKVector2 moveVelocity;
@property(nonatomic, assign)GLKVector2 position;

- (void)slice:(CGRect)rect textureSize:(CGSize)size;
- (void)update:(NSTimeInterval)tick;

@end
