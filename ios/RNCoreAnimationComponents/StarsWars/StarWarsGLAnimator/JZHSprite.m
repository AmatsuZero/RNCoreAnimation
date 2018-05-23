//
//  JZHSprite.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHSprite.h"

@implementation TexturedVertex

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    TexturedVertex* vertex = [[self class] allocWithZone:zone];
    vertex.geometryVertex = self.geometryVertex;
    vertex.textureVertex = self.textureVertex;
    return vertex;
}

- (instancetype)init {
    if (self = [super init]) {
        _geometryVertex = GLKVector2Make(0, 0);
        _textureVertex = GLKVector2Make(0, 0);
    }
    return self;
}

@end

@implementation TexturedQuad
{
    TexturedVertex* _bbr;
    TexturedVertex* _ttl;
}

- (instancetype)init {
    if (self = [super init]) {
        _bl = [TexturedVertex new];
        _br = [TexturedVertex new];
        _tl = [TexturedVertex new];
        _tr = [TexturedVertex new];
        _bbr = [TexturedVertex new];
        _ttl = [TexturedVertex new];
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    TexturedQuad* quad = [[self class] allocWithZone:zone];
    quad.bl = self.bl;
    quad.br = self.br;
    quad.tl = self.tl;
    quad.tr = self.tr;
    return quad;
}

- (void)setBr:(TexturedVertex *)br {
    _br = [br copy];
    _bbr = [br copy];
}

- (void)setTl:(TexturedVertex *)tl {
    _tl = [tl copy];
    _ttl = [tl copy];
}

@end

@implementation JZHSprite

- (instancetype)init {
    if (self = [super init]) {
        _quad = [TexturedQuad new];
        _moveVelocity = GLKVector2Make(0, 0);
        _position = GLKVector2Make(0, 0);
    }
    return self;
}

- (void)slice:(CGRect)rect textureSize:(CGSize)size {
    _quad.bl.geometryVertex = GLKVector2Make(0, 0);
    _quad.br.geometryVertex = GLKVector2Make(rect.size.width, 0);
    _quad.tl.geometryVertex = GLKVector2Make(0, rect.size.height);
    _quad.tr.geometryVertex = GLKVector2Make(rect.size.width, rect.size.height);

    _quad.bl.textureVertex = GLKVector2Make(rect.origin.x / size.width, rect.origin.y / size.height);
    _quad.br.textureVertex = GLKVector2Make(CGRectGetMaxX(rect) / size.width, rect.origin.y / size.height);
    _quad.tl.textureVertex = GLKVector2Make(rect.origin.x / size.width, CGRectGetMaxY(rect) / size.height);
    _quad.tr.textureVertex = GLKVector2Make(CGRectGetMaxX(rect) / size.width, CGRectGetMaxY(rect) / size.height);

    self.position = GLKVector2Add(self.position, GLKVector2Make(rect.origin.x, rect.origin.y));
}

- (void)setPosition:(GLKVector2)position {
    GLKVector2 diff = GLKVector2Add(position, GLKVector2Negate(_position));
    _quad.bl.geometryVertex = GLKVector2Add(diff, _quad.bl.geometryVertex);
    _quad.br.geometryVertex = GLKVector2Add(diff, _quad.br.geometryVertex);
    _quad.tl.geometryVertex = GLKVector2Add(diff, _quad.tl.geometryVertex);
    _quad.tr.geometryVertex = GLKVector2Add(diff, _quad.tr.geometryVertex);

     _position = position;
}

- (void)update:(NSTimeInterval)tick {
    self.position = GLKVector2Add(_position, GLKVector2MultiplyScalar(_moveVelocity, tick));
}

@end
