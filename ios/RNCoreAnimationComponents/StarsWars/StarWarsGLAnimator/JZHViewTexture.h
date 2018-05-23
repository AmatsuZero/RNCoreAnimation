//
//  JZHViewTexture.h
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/23.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface JZHViewTexture : UIView
{
    @public
    GLuint name;
    GLuint width;
    GLsizei height;
}

- (void)render:(UIView*)view;
- (void)setupOpenGL;

@end
