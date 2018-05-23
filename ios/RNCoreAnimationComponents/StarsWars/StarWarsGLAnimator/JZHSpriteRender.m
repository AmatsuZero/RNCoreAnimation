//
//  JZHSpriteRender.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHSpriteRender.h"


@implementation JZHSpriteRender
{
    JZHViewTexture* texture;
    GLKBaseEffect* effect;
}

- (instancetype)initWithTexture:(JZHViewTexture *)texture effect:(GLKBaseEffect *)effect {
    if (self = [super init]) {
        self->texture = texture;
        self->effect = effect;
    }
    return self;
}

- (void)render:(NSArray<JZHSprite*> *)sprites {
    effect.texture2d0.name = texture->name;
    effect.texture2d0.enabled = 1;

    NSArray<TexturedQuad*>* vertex = [sprites valueForKeyPath:@"quad"];
    GLKVector2 vex = [vertex firstObject].bl.geometryVertex;
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(vex), &vex);
    vex = [vertex firstObject].bl.textureVertex;
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(vex), &vex);

    glDrawArrays(GL_TRIANGLES, 0, (GLsizei)vertex.count*6);
}

@end
