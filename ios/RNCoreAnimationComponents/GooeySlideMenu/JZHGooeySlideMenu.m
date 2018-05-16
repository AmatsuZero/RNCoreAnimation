//
//  JZHGooeySlideMenu.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/15.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHGooeySlideMenu.h"
#import "JZHSlideMenuButton.h"
#import "NSString+JZHColorConvertor.h"

@interface JZHGooeySlideMenu()

@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic, assign)NSInteger animationCount; // 动画的数量

@end

@implementation JZHGooeySlideMenu{
    UIVisualEffectView *blurView;
    UIView *helperSideView;
    UIView *helperCenterView;
    UIWindow *keyWindow;
    BOOL triggered;
    CGFloat diff;
    UIColor *_menuColor;
    CGFloat menuButtonHeight;
}

- (instancetype)init {
    if (self = [super init]) {
        _buttonSpace = 30;
        _menuColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
        self.style = UIBlurEffectStyleDark;
        _buttonHeight = 40.0f;
        keyWindow = [[UIApplication sharedApplication] keyWindow];

        helperSideView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 40, 40)];
        helperSideView.backgroundColor = [UIColor redColor];
        helperSideView.hidden = YES;
        [keyWindow addSubview:helperSideView];

        helperCenterView = [[UIView alloc]initWithFrame:CGRectMake(-40, CGRectGetHeight(keyWindow.frame)/2 - 20, 40, 40)];
        helperCenterView.backgroundColor = [UIColor yellowColor];
        helperCenterView.hidden = YES;
        [keyWindow addSubview:helperCenterView];

        self.menuBlankWidth = 50;
        self.backgroundColor = [UIColor clearColor];
        [keyWindow insertSubview:self belowSubview:helperSideView];
    }
    return self;
}

- (void)trigger {
    if (!triggered) {
        [keyWindow insertSubview:blurView belowSubview:self];
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.bounds;
        }];

        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            self->helperSideView.center = CGPointMake(self->keyWindow.center.x, self->helperSideView.frame.size.height/2);
        } completion:^(BOOL finished) {
            [self finishAnimation];
        }];

        [UIView animateWithDuration:0.3 animations:^{
            self->blurView.alpha = 1.0f;
        }];

        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            self->helperCenterView.center = self->keyWindow.center;
        } completion:^(BOOL finished) {
            if (finished) {
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToUntrigger)];
                [self->blurView addGestureRecognizer:tapGes];
                [self finishAnimation];
            }
        }];
        [self animateButtons];
        triggered = YES;
    }else{
        [self tapToUntrigger];
    }
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(self.frame.size.width-self.menuBlankWidth, 0)];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width-self.menuBlankWidth,
                                          self.frame.size.height)
                 controlPoint:CGPointMake(keyWindow.frame.size.width/2+diff, keyWindow.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
}

-(void)animateButtons {
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIView *menuButton = self.subviews[i];
        menuButton.transform = CGAffineTransformMakeTranslation(-90, 0);
        [UIView animateWithDuration:0.7
                              delay:i*(0.3/self.subviews.count)
             usingSpringWithDamping:0.6f
              initialSpringVelocity:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
            menuButton.transform =  CGAffineTransformIdentity;
        } completion: nil];
    }
}

-(void)tapToUntrigger{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(-self->keyWindow.frame.size.width/2-self.menuBlankWidth, 0, self->keyWindow.frame.size.width/2+self->_menuBlankWidth, self->keyWindow.frame.size.height);
    }];
    [self beforeAnimation];
    [UIView animateWithDuration:0.7
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:0.9f
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        self->helperSideView.center = CGPointMake(-self->helperSideView.frame.size.height/2,
                                                  self->helperSideView.frame.size.height/2);
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];

    [UIView animateWithDuration:0.3 animations:^{
        self->blurView.alpha = 0.0f;
    }];

    [self beforeAnimation];
    [UIView animateWithDuration:0.7
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:2.0f
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self->helperCenterView.center = CGPointMake(-self->helperSideView.frame.size.height/2,
                                                                     CGRectGetHeight(self->keyWindow.frame)/2);
                     } completion:^(BOOL finished) {
                         [self finishAnimation];
                     }];
    triggered = NO;
}

//动画之前调用
-(void)beforeAnimation {
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                       selector:@selector(displayLinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

//动画完成之后调用
-(void)finishAnimation {
    self.animationCount --;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

-(void)displayLinkAction:(CADisplayLink *)dis{
    CALayer *sideHelperPresentationLayer   =  [helperSideView.layer presentationLayer];
    CALayer *centerHelperPresentationLayer =  [helperCenterView.layer presentationLayer];
    CGRect centerRect = [[centerHelperPresentationLayer valueForKeyPath:@"frame"]CGRectValue];
    CGRect sideRect = [[sideHelperPresentationLayer valueForKeyPath:@"frame"]CGRectValue];
    diff = sideRect.origin.x - centerRect.origin.x;
    [self setNeedsDisplay];
}


#pragma mark - Setters
- (void)setStyle:(UIBlurEffectStyle)style {
    if (_style == style) {
        return;
    }
    _style = style;
    blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
    blurView.frame = keyWindow.frame;
    blurView.alpha = 0.0f;
    [self setNeedsDisplay];
}

- (void)setMenuBlankWidth:(CGFloat)menuBlankWidth {
    _menuBlankWidth = menuBlankWidth;
    self.frame = CGRectMake(- keyWindow.frame.size.width/2 - menuBlankWidth,
                            0,
                            keyWindow.frame.size.width/2 + menuBlankWidth,
                            keyWindow.frame.size.height);
    [self setNeedsDisplay];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    if (titles.count % 2 == 0) {
        NSInteger index_down = titles.count/2;
        NSInteger index_up = -1;
        for (NSInteger i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            JZHSlideMenuButton *home_button = [[JZHSlideMenuButton alloc]initWithTitle:title];
            if (i >= titles.count / 2) {
                index_up ++;
                home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 + menuButtonHeight*index_up + _buttonSpace*index_up + _buttonSpace/2 + menuButtonHeight/2);
            }else{
                index_down --;
                home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - menuButtonHeight*index_down - _buttonSpace*index_down - _buttonSpace/2 - menuButtonHeight/2);
            }

            home_button.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 20*2, menuButtonHeight);
            home_button.buttonColor = _menuColor;
            [self addSubview:home_button];
            __weak typeof(self) WeakSelf = self;
            home_button.buttonClickBlock = ^(){
                [WeakSelf tapToUntrigger];
                if (WeakSelf.menuClickBlock) {
                    WeakSelf.menuClickBlock(@{@"index": @(i),
                                              @"title": title,
                                              @"count": @(titles.count)});
                }
            };
        }
    } else{
        NSInteger index = (titles.count - 1) /2 +1;
        for (NSInteger i = 0; i < titles.count; i++) {
            index --;
            NSString *title = titles[i];
            JZHSlideMenuButton *home_button = [[JZHSlideMenuButton alloc]initWithTitle:title];
            home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - menuButtonHeight*index - 20*index);
            home_button.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 20*2, menuButtonHeight);
            home_button.buttonColor = _menuColor;
            [self addSubview:home_button];

            __weak typeof(self) WeakSelf = self;
            home_button.buttonClickBlock = ^(){
                [WeakSelf tapToUntrigger];
                if (WeakSelf.menuClickBlock) {
                    WeakSelf.menuClickBlock(@{@"index": @(i),
                                              @"title": title,
                                              @"count": @(titles.count)});
                }
            };
        }
    }
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color {
    _menuColor = [color hexToColor];
    [self setNeedsDisplay];
}

@end
