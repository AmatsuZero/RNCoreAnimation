//
//  JZHCGValueManipulation.h
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#ifndef JZHCGValueManipulation_h
#define JZHCGValueManipulation_h

#include <stdio.h>
#include <math.h>
#import <CoreGraphics/CGGeometry.h>
#import <CoreFoundation/CoreFoundation.h>

CGPoint CGPointPlus(CGPoint pt1, CGPoint pt2);
CGPoint CGPointPlusX(CGPoint pt, CGFloat dx);
CGPoint CGPointPlusY(CGPoint pt, CGFloat dy);

CGPoint CGPointMinus(CGPoint pt, CGPoint);
CGPoint CGPointMinusX(CGPoint pt, CGFloat);
CGPoint CGPointMinusY(CGPoint pt, CGFloat);

CGPoint CGPointMultiply(CGPoint, CGFloat mul);

CGPoint CGPointDivide(CGPoint, CGFloat div);

CGFloat CGPointGetLength(CGPoint);

CGPoint CGPointReverse(CGPoint);
CGPoint CGPointReverseX(CGPoint);
CGPoint CGPointReverseY(CGPoint);

CGPoint CGPointRefX(CGPoint, CGPoint target);
CGPoint CGPointRefY(CGPoint, CGPoint target);

CGPoint CGPointCeil(CGPoint);

CGPoint CGPointNomalized(CGPoint);

CGFloat CGPointDot(CGPoint, CGPoint);

CGFloat CGPointCross(CGPoint, CGPoint);

CGPoint CGPointSplit(CGPoint pt1, CGPoint pt2, CGFloat ratio);

CGPoint CGPointMid(CGPoint, CGPoint);

CGSize CGPointAreaSize(CGPoint, CGPoint);
CGFloat CGPointArea(CGPoint, CGPoint);

CGPoint CGPointOrigin(CGPoint, CGPoint);
CGPoint CGPointIntersection(CGPoint from1, CGPoint to1, CGPoint from2, CGPoint to2);

CGPoint CGRectGetRightBottom(CGRect);
CGPoint CGRectGetCenter(CGRect);

CGFloat CGMathRadToDeg(CGFloat rad);
CGFloat CGMathDegToRad(CGFloat deg);
CGPoint CGMathCirclePoint(CGPoint center, CGFloat radius, CGFloat rad);

#endif /* JZHCGValueManipulation_h */
