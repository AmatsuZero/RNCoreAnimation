//
//  JZHViewTexture.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHViewTexture.h"

@implementation JZHViewTexture

- (instancetype)init {
    if (self = [super init]) {
        name = 0;
        width = 0;
        height = 0;
    }
    return self;
}

- (void)dealloc {
    if (name == 0) {
        glDeleteTextures(1, &name);
    }
}

- (void)setupOpenGL {
    glGenTextures(1, &name);
    glBindTexture(GL_TEXTURE_2D, name);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glBindTexture(GL_TEXTURE_2D, 0);
}

- (void)render:(UIView*)view {
    CGFloat scale = [UIScreen mainScreen].scale;
    width = (GLsizei)(view.layer.bounds.size.width * scale);
    height = (GLsizei)(view.layer.bounds.size.height * scale);

    size_t count = (int)height * width * 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    GLubyte *texturePixelBuffer = calloc(count, sizeof(GLubyte));
    CGContextRef context = CGBitmapContextCreateWithData(texturePixelBuffer, (int)width, (int)height, 8, (int)width*4, colorSpace,
                                                         kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, NULL, NULL);
    CGContextScaleCTM(context, scale, scale);

    UIGraphicsPushContext(context);
    [view drawViewHierarchyInRect:view.layer.bounds afterScreenUpdates:NO];
    UIGraphicsPopContext();

    glBindTexture(GL_TEXTURE_2D, name);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, texturePixelBuffer);
    glBindTexture(GL_TEXTURE_2D, 0);

    free(texturePixelBuffer);
}

@end
