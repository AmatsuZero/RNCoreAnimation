//
//  JZHStyleKit.m
//  RNCoreAnimationComponents
//
//  Created by modao on 2018/5/29.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#import "JZHStyleKit.h"

@implementation JZHStyleKit

+ (void)drawToDownloadState:(CGRect)targetFrame
                   resizing:(JZHResizingBehavior *)resizing
                    palette:(JZHPalette *)palette
      toDownloadManipulable:(CGFloat)toDownloadManipulable {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 50, 50) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/50, CGRectGetHeight(resizeFrame)/50);

    // Arrow Download
    CGContextSaveGState(context);
    CGContextSetAlpha(context, toDownloadManipulable);
    CGContextBeginTransparencyLayer(context, NULL);

    // Rectangle 3 Drawing
    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect:CGRectMake(15, 36, 20, 2)];
    [palette.initialColor setFill];
    [rectangle3Path fill];

    // Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(24, 12)];
    [bezierPath addLineToPoint:CGPointMake(24, 32.2)];
    [bezierPath addLineToPoint:CGPointMake(18.4, 26.6)];
    [bezierPath addLineToPoint:CGPointMake(17, 28)];
    [bezierPath addLineToPoint:CGPointMake(25, 36)];
    [bezierPath addLineToPoint:CGPointMake(33, 28)];
    [bezierPath addLineToPoint:CGPointMake(31.6, 26.6)];
    [bezierPath addLineToPoint:CGPointMake(26, 32.2)];
    [bezierPath addLineToPoint:CGPointMake(26, 12)];
    [bezierPath addLineToPoint:CGPointMake(24, 12)];
    [palette.initialColor setFill];
    [bezierPath fill];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 0;
    [bezierPath stroke];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

+ (void)drawRippleState:(CGRect)targetFrame
               resizing:(JZHResizingBehavior *)resizing
                palette:(JZHPalette *)palette
     rippleManipulable:(CGFloat)rippleManipulable {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 50, 50) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/50, CGRectGetHeight(resizeFrame)/50);

     // Variable Declarations
    CGFloat rippleDimensions = 31 + rippleManipulable * 15;
    CGFloat rippleOrigin = -1 * rippleDimensions / 2.f;
    CGFloat rippleAlpha = rippleManipulable < 0.5 ? rippleManipulable : 1 - rippleManipulable;
    CGFloat requestDownloadSquareAlpha = rippleManipulable;
    CGFloat requestDownloadReveal = rippleManipulable * 34;

    // Dashed Circle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    CGContextSaveGState(context);
    CGContextSetBlendMode(context, kCGBlendModeDestinationAtop);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* dashedCirclePath  = [UIBezierPath bezierPath];
    [dashedCirclePath moveToPoint:CGPointMake(15, 0)];
    [dashedCirclePath addCurveToPoint:CGPointMake(0, 15)
                        controlPoint1:CGPointMake(15, 8.28)
                        controlPoint2:CGPointMake(8.28, 15)];
    [dashedCirclePath addCurveToPoint:CGPointMake(-15, 0)
                        controlPoint1:CGPointMake(-8.28, 15)
                        controlPoint2:CGPointMake(-15, 8.28)];
    [dashedCirclePath addCurveToPoint:CGPointMake(0, -15)
                        controlPoint1:CGPointMake(-15, -8.28)
                        controlPoint2:CGPointMake(-8.28, -15)];
    [dashedCirclePath addCurveToPoint:CGPointMake(15, 0)
                        controlPoint1:CGPointMake(8.28, -15)
                        controlPoint2:CGPointMake(15, -8.28)];
    [dashedCirclePath closePath];
    [palette.downloadColor setStroke];
    dashedCirclePath.lineWidth = 1;
    CGContextSaveGState(context);
    CGFloat lengths[2]  = {5,3.5};
    CGContextSetLineDash(context, 5, lengths, 2);
    [dashedCirclePath stroke];
    CGContextSaveGState(context);

    CGContextEndTransparencyLayer(context);
    CGContextSaveGState(context);

    CGContextSaveGState(context);

    // Reveal Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    CGContextRotateCTM(context, -100 * M_PI / 180);

    CGContextSaveGState(context);
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* revealPath = [UIBezierPath bezierPathWithRect:CGRectMake(-17, -17, 34, requestDownloadReveal)];
    [palette.downloadColor setFill];
    [revealPath fill];

    CGContextEndTransparencyLayer(context);
    CGContextSaveGState(context);

    CGContextSaveGState(context);

    // Square Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    CGContextSaveGState(context);
    CGContextSetAlpha(context, requestDownloadSquareAlpha);

    UIBezierPath* squarePath = [UIBezierPath bezierPathWithRect:CGRectMake(-3.75, -3.75, 7.5, 7.5)];
    [palette.downloadColor setFill];
    [squarePath fill];

    CGContextSaveGState(context);
    CGContextSaveGState(context);

    // RippleCircle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    CGContextSaveGState(context);
    CGContextSetAlpha(context, rippleAlpha);

    UIBezierPath* rippleCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rippleOrigin, rippleOrigin, rippleDimensions, rippleDimensions)];
    [palette.rippleColor setStroke];
    rippleCirclePath.lineWidth = 2.5;
    [rippleCirclePath stroke];

    CGContextSaveGState(context);
    CGContextSaveGState(context);
    CGContextSaveGState(context);
}

+ (void)drawDownloadCompleteState:(CGRect)targetFrame
                         resizing:(JZHResizingBehavior *)resizing
                          palette:(JZHPalette *)palette
            downloadedManipulable:(CGFloat)downloadedManipulable {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 50, 50) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/50, CGRectGetHeight(resizeFrame)/50);

    // Variable Declarations
    CGFloat downloadedCircleOpacity = 1 - downloadedManipulable;
    CGFloat downloadedCenterDarkCicleDimensions = 11 + (1 - downloadedManipulable) * 15;
    CGFloat downloadedCenterDarkCicleOrigin = downloadedCenterDarkCicleDimensions / 2.0 * -1;
    CGFloat downloadedScreenWidth = 18 + downloadedManipulable * 4;
    CGFloat downloadedScreenOriginX = -1 * downloadedScreenWidth / 2.0;
    CGFloat downloadedScreenHeight = 28 + downloadedManipulable * 4;
    CGFloat downloadedScreenOriginY = -1 * downloadedScreenHeight / 2.0;

    // Group
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    CGContextSetAlpha(context, downloadedCircleOpacity);
    CGContextBeginTransparencyLayer(context, NULL);

    // Full Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.5, -0.5);
    CGContextRotateCTM(context, -90 * M_PI * 180);

    UIBezierPath* fullPath  = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-15, -15, 29, 29)];
    [palette.downloadColor setFill];
    [fullPath fill];
    [palette.downloadColor setStroke];
    fullPath.lineWidth = 2;
    [fullPath stroke];

    CGContextRestoreGState(context);

    // Full Center Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, downloadedCenterDarkCicleOrigin+13, downloadedCenterDarkCicleOrigin+13);
    UIBezierPath* fullCenterPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-13.03, -12.97, downloadedCenterDarkCicleDimensions, downloadedCenterDarkCicleDimensions)];
    [palette.buttonBackgroundColor setFill];
    [palette.buttonBackgroundColor setStroke];
    fullCenterPath.lineWidth = 0.5;
    [fullCenterPath stroke];
    CGContextRestoreGState(context);

    // Square Drawing
    CGContextSaveGState(context);

    CGContextSaveGState(context);
    CGContextSetAlpha(context, downloadedCircleOpacity);

    UIBezierPath* squarePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-3.75, -3.75, 7.5, 7.5)];
    [palette.downloadColor setFill];
    [squarePath fill];

    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);

    #if TARGET_OS_IPHONE
    // SymboliPhone Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    CGContextSaveGState(context);
    CGContextSetAlpha(context, downloadedManipulable);
    CGContextBeginTransparencyLayer(context, NULL);

    CGRect symboliPhoneRect = CGRectMake(downloadedScreenOriginX, downloadedScreenOriginY, downloadedScreenWidth, downloadedScreenHeight);
    CGContextSaveGState(context);
    CGContextClip(context);
    CGContextTranslateCTM(context, CGRectGetMinX(symboliPhoneRect), CGRectGetMinY(symboliPhoneRect));

    [self drawiPhoneCanvas:CGRectMake(0, 0, CGRectGetWidth(symboliPhoneRect), CGRectGetHeight(symboliPhoneRect))
                  resizing:[JZHResizingBehavior stretch]
                   palette:palette];
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    #elif TARGET_OS_TV
    CGFloat downloadedTVWidth = 16 + downloadedManipulable * 4;
    CGFloat downloadedTVOriginX = -1 * downloadedTVWidth / 2.0;
    CGFloat downloadedTVHeight = 25 + downloadedManipulable * 4;
    CGFloat downloadedTVOriginY = -1 * downloadedTVHeight / 2.f;

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    CGRect symbolTVRect = CGRectMake(-20, -14.5, 40, 29);
    CGContextSaveGState(context);
    CGContextClipToRect(context, symbolTVRect);
    CGContextTranslateCTM(context, CGRectGetMinX(symbolTVRect), CGRectGetMinY(symbolTVRect));

    [self drawAppleTVCanvas:CGRectMake(0, 0, CGRectGetWidth(symbolTVRect), CGRectGetHeight(symbolTVRect))
                   resizing:[JZHResizingBehavior stretch]
                    palette:palette];
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    #endif
}


+ (void)drawCheckState:(CGRect)targetFrame
              resizing:(JZHResizingBehavior*)resizing
               palette: (JZHPalette*)palette
 downloadedManipulable:(CGFloat)downloadedManipulable
checkRevealManipulable:(CGFloat)checkRevealManipulable {

    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 50, 50) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/50, CGRectGetHeight(resizeFrame)/50);

    CGFloat checkRevealWidth = checkRevealManipulable * 17;
    #if TARGET_OS_IPHONE
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    CGRect symboliPhoneRect = CGRectMake(-11, -16, 22, 32);
    CGContextSaveGState(context);
    CGContextClipToRect(context, symboliPhoneRect);
    CGContextTranslateCTM(context, CGRectGetMinX(symboliPhoneRect), CGRectGetMinY(symboliPhoneRect));

    [self drawiPhoneCanvas:CGRectMake(0, 0, CGRectGetWidth(symboliPhoneRect), CGRectGetHeight(symboliPhoneRect))
                  resizing:[JZHResizingBehavior stretch]
                   palette:palette];
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    #elif TARGET_OS_TV
    //// SymbolTV Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    CGRect symbolTVRect = CGRectMake(-20, -14.5, 40, 29);
    CGContextSaveGState(context);
    CGContextClipToRect(context, symbolTVRect);
    CGContextTranslateCTM(context, CGRectGetMinX(symbolTVRect), CGRectGetMinY(symbolTVRect));

    [self drawAppleTVCanvas:CGRectMake(0, 0, CGRectGetWidth(symbolTVRect), CGRectGetHeight(symbolTVRect))
                   resizing:[JZHResizingBehavior stretch]
                    palette:palette];

    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    #endif

    /// Group
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    CGContextBeginTransparencyLayer(context, NULL);

    /// Check Drawing
    UIBezierPath* checkPath = [UIBezierPath bezierPath];
    [checkPath moveToPoint:CGPointMake(-6.29, 0.94)];
    [checkPath addLineToPoint:CGPointMake(-5.38, -0.07)];
    [checkPath addLineToPoint:CGPointMake(-2.65, 2.96)];
    [checkPath addLineToPoint:CGPointMake(5.09, -5.13)];
    [checkPath addLineToPoint:CGPointMake(6.45, -3.62)];
    [checkPath addLineToPoint:CGPointMake(-2.65, 6)];
    [checkPath addLineToPoint:CGPointMake(-6.75, 1.44)];
    [checkPath addLineToPoint:CGPointMake(-6.29, 0.94)];
    [checkPath closePath];
    [palette.deviceColor setFill];
    [checkPath fill];

    //// Rectangle 4 Drawing
    CGContextSaveGState(context);
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRect:CGRectMake(-9, -7, checkRevealWidth+1, 16)];
    [palette.deviceColor setFill];
    [rectangle4Path fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

+ (void)drawiPhoneCanvas:(CGRect)targetFrame resizing:(JZHResizingBehavior*)resizing palette:(JZHPalette*)palette {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 20, 30) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/20, CGRectGetHeight(resizeFrame)/30);

    // iPhone
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 9, 14);

    // Rim Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 1, 1);

    UIBezierPath* rimPath = [UIBezierPath bezierPathWithRect:CGRectMake(-6.5, -12.5, 13, 25)];
    [palette.deviceColor setFill];
    [rimPath fill];
    [palette.deviceColor setStroke];
    rimPath.lineWidth = 5;
    rimPath.lineJoinStyle = kCGLineJoinRound;
    [rimPath stroke];

    CGContextRestoreGState(context);

    // Screen Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 1, 1);

    UIBezierPath* screenPath = [UIBezierPath bezierPathWithRect:CGRectMake(-8, -13, 16, 26)];
    [palette.buttonBackgroundColor setFill];
    [screenPath fill];

    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

+ (void)drawAppleTVCanvas:(CGRect)targetFrame resizing:(JZHResizingBehavior*)resizing palette:(JZHPalette*)palette {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 226, 162) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/226, CGRectGetHeight(resizeFrame)/162);

    // Page-1
    // Apple-Icon-Set
    // iMac
    // Rectangle-18 Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPath];
    [rectanglePath moveToPoint:CGPointMake(0, 153.44)];
    [rectanglePath addCurveToPoint:CGPointMake(0.54, 162) controlPoint1:CGPointMake(0, 158.17) controlPoint2:CGPointMake(3.83, 162)];
    [rectanglePath addLineToPoint:CGPointMake(214.2, 162)];
    [rectanglePath addLineToPoint:CGPointMake(215.31, 162)];
    [rectanglePath addLineToPoint:CGPointMake(217.46, 162)];
    [rectanglePath addCurveToPoint:CGPointMake(226, 153.44) controlPoint1:CGPointMake(222.17, 162) controlPoint2:CGPointMake(226, 158.17)];
    [rectanglePath addLineToPoint:CGPointMake(226, 8.56)];
    [rectanglePath addCurveToPoint:CGPointMake(217.46, 0) controlPoint1:CGPointMake(226, 3.83) controlPoint2:CGPointMake(222.17, 0)];
    [rectanglePath addLineToPoint:CGPointMake(8.54, 0)];
    [rectanglePath addCurveToPoint:CGPointMake(0, 8.56) controlPoint1:CGPointMake(3.83, 0) controlPoint2:CGPointMake(0, 3.83)];
    [rectanglePath addLineToPoint:CGPointMake(0, 153.44)];
    [rectanglePath closePath];
    [palette.deviceColor setFill];
    [rectanglePath fill];

    // Rectangle-19 Drawing
    UIBezierPath* rectangle19Path = [UIBezierPath bezierPath];
    [rectangle19Path moveToPoint:CGPointMake(10, 150)];
    [rectangle19Path addLineToPoint:CGPointMake(215, 150)];
    [rectangle19Path addLineToPoint:CGPointMake(215, 10)];
    [rectangle19Path addLineToPoint:CGPointMake(10, 10)];
    [rectangle19Path addLineToPoint:CGPointMake(10, 150)];
    [rectangle19Path closePath];
    [palette.buttonBackgroundColor setFill];
    [rectangle19Path fill];

    CGContextRestoreGState(context);
}

+ (void)drawReadyToDownloadState:(CGRect)targetFrame
                        resizing:(JZHResizingBehavior *)resizing
                         palette:(JZHPalette *)palette
      readyToDownloadManipulable:(CGFloat)readyToDownloadManipulable {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 50, 50) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/50, CGRectGetHeight(resizeFrame)/50);

    // Variable Declarations
    CGFloat readyToDownloadAngle = readyToDownloadManipulable == 1 ? - 360 : 360 - readyToDownloadManipulable * 360;

    // Dashed Circle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    UIBezierPath* dashedCirclePath = [UIBezierPath bezierPath];
    [dashedCirclePath moveToPoint:CGPointMake(15, 0)];
    [dashedCirclePath addCurveToPoint:CGPointMake(0, 15) controlPoint1:CGPointMake(15, 8.28) controlPoint2:CGPointMake(8.28, 15)];
    [dashedCirclePath addCurveToPoint:CGPointMake(-15, 0) controlPoint1:CGPointMake(-8.28, 15) controlPoint2:CGPointMake(-15, 8.28)];
    [dashedCirclePath addCurveToPoint:CGPointMake(0, -15) controlPoint1:CGPointMake(-15, -8.28) controlPoint2:CGPointMake(-8.28, -15)];
    [dashedCirclePath addCurveToPoint:CGPointMake(15, 0) controlPoint1:CGPointMake(8.28, -15) controlPoint2:CGPointMake(15, -8.28)];
    [dashedCirclePath closePath];

    [palette.buttonBackgroundColor setFill];
    [dashedCirclePath fill];
    [palette.downloadColor setStroke];
    dashedCirclePath.lineWidth = 1;
    [dashedCirclePath stroke];

    CGContextRestoreGState(context);

    // Download Tack Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    CGContextRotateCTM(context, -90 * M_PI / 180);

    CGRect downloadTackRect = CGRectMake(-14, -14, 28, 28);
    UIBezierPath* downloadTackPath = [UIBezierPath bezierPath];
    [downloadTackPath addArcWithCenter:CGPointMake(CGRectGetMinX(downloadTackRect), CGRectGetMidY(downloadTackRect))
                                radius:CGRectGetWidth(downloadTackRect)/2
                            startAngle:0
                              endAngle:-readyToDownloadAngle*M_PI/180
                             clockwise: YES];
    [palette.downloadColor setStroke];
    downloadTackPath.lineWidth = 2.5;
    [downloadTackPath stroke];

    CGContextRestoreGState(context);

    // Square Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);

    UIBezierPath* squarePath = [UIBezierPath bezierPathWithRect:CGRectMake(-3.75, -3.75, 7.5, 7.5)];
    [palette.downloadColor setFill];
    [squarePath fill];

    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

+ (void)drawDashMoveState:(CGRect)targetFrame resizing:(JZHResizingBehavior *)resizing palette:(JZHPalette *)palette dashMoveManipulable:(CGFloat)dashMoveManipulable {
    // General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizeFrame = [resizing apply:CGRectMake(0, 0, 50, 50) to:targetFrame];
    CGContextTranslateCTM(context, CGRectGetMinX(resizeFrame), CGRectGetMinY(resizeFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizeFrame)/50, CGRectGetHeight(resizeFrame)/50);
    
    // Variable Declarations
    CGFloat dashMoveCircleRotation = dashMoveManipulable * 15 * -1;
    CGFloat dashMoveDashedCircleDash = ABS(dashMoveCircleRotation) > 15 ? 0 : 5;
    CGFloat dashMoveDashedCircleGap = ABS(dashMoveCircleRotation) >= 15 ? 0 : 3.5;
    CGFloat dashMoveDashedCirclePhase = ABS(dashMoveCircleRotation) > 15 ? 0 : 5;
    
    // Moving Declarations
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    CGContextRotateCTM(context, -dashMoveCircleRotation * M_PI / 180);
    
    UIBezierPath* movingDashedCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-15, -15, 30, 30)];
    [palette.downloadColor setStroke];
    movingDashedCirclePath.lineWidth = 1;
    CGContextSaveGState(context);
    CGFloat lengths[2]  = {dashMoveDashedCircleDash, dashMoveDashedCircleGap};
    CGContextSetLineDash(context, dashMoveDashedCirclePhase, lengths, 2);
    [movingDashedCirclePath stroke];
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    
    // Dashed Circle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    
    UIBezierPath* dashedCiclePath = [UIBezierPath bezierPath];
    [dashedCiclePath moveToPoint:CGPointMake(15, 0)];
    [dashedCiclePath addCurveToPoint:CGPointMake(0, 15) controlPoint1:CGPointMake(15, 8.28) controlPoint2:CGPointMake(8.28, 15)];
    [dashedCiclePath addCurveToPoint:CGPointMake(-15, 0) controlPoint1:CGPointMake(-8.28, 15) controlPoint2:CGPointMake(-15, 8.28)];
    [dashedCiclePath addCurveToPoint:CGPointMake(0, -15) controlPoint1:CGPointMake(-15, 8.28) controlPoint2:CGPointMake(-8.28, -15)];
    [dashedCiclePath addCurveToPoint:CGPointMake(15, 0) controlPoint1:CGPointMake(8.28, -15) controlPoint2:CGPointMake(15, -8.28)];
    [dashedCiclePath closePath];
    [palette.downloadColor setStroke];
    dashedCiclePath.lineWidth = 1;
    CGContextSaveGState(context);
    CGFloat dashes[2] = {5, 3.5};
    CGContextSetLineDash(context, 5, dashes, 2);
    [dashedCiclePath stroke];
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    
    // Square Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 25, 25);
    
    UIBezierPath* squarePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-3.75, -3.75, 7.5, 7.5)];
    [palette.downloadColor setFill];
    [squarePath fill];
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

@end
