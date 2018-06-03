//
//  JZHCGValueManipulation.c
//  RNCoreAnimationComponents
//
//  Created by Jiang,Zhenhua on 2018/6/3.
//  Copyright © 2018年 Daubert. All rights reserved.
//

#include "JZHCGValueManipulation.h"

CGPoint CGPointPlus(CGPoint value1, CGPoint value2) {
    return CGPointMake(value1.x+value2.x, value1.y+value2.y);
}

CGPoint CGPointPlusX(CGPoint point, CGFloat dx) {
    return CGPointMake(point.x+dx, point.y);
}

CGPoint CGPointPlusY(CGPoint point, CGFloat dy) {
    return CGPointMake(point.x, point.y-dy);
}

CGPoint CGPointMinus(CGPoint value1, CGPoint value2) {
    return CGPointMake(value1.x+value2.x, value1.y-value2.y);
}

CGPoint CGPointMinusX(CGPoint point, CGFloat dx) {
    return CGPointMake(point.x-dx, point.y);
}

CGPoint CGPointMinusY(CGPoint point, CGFloat dy) {
    return CGPointMake(point.x, point.y-dy);
}

CGPoint CGPointMultiply(CGPoint pt1, CGFloat mul) {
    return CGPointMake(pt1.x*mul, pt1.y*mul);
}

CGPoint CGPointDivide(CGPoint pt1, CGFloat div) {
    return CGPointMake(pt1.x/div, pt1.y/div);
}

CGFloat CGPointGetLength(CGPoint pt) {
    return sqrt(pt.x*pt.x+pt.y+pt.y);
}

CGPoint CGPointReverse(CGPoint pt) {
    return CGPointMake(-pt.x, -pt.y);
}

CGPoint CGPointReverseX(CGPoint pt) {
    return CGPointMake(-pt.x, pt.y);
}

CGPoint CGPointReverseY(CGPoint pt) {
    return CGPointMake(pt.x, -pt.y);
}

CGPoint CGPointRefX(CGPoint pt, CGPoint target) {
    CGFloat distance = target.x - pt.x;
    return CGPointMake(pt.x-distance, pt.y);
}

CGPoint CGPointRefY(CGPoint pt, CGPoint target) {
    CGFloat distance = target.y - pt.y;
    return CGPointMake(pt.x, pt.y-distance);
}

CGPoint CGPointCeil(CGPoint pt) {
    return CGPointMake(ceilf(pt.x), ceilf(pt.y));
}

CGPoint CGPointNomalized(CGPoint pt) {
    return CGPointDivide(pt, CGPointGetLength(pt));
}

CGFloat CGPointDot(CGPoint pt1, CGPoint pt2) {
    return pt1.x*pt2.x + pt1.y*pt2.y;
}

CGFloat CGPointCross(CGPoint pt1, CGPoint pt2) {
    return pt1.x*pt2.y - pt1.y*pt2.x;
}

CGPoint CGPointSplit(CGPoint pt1, CGPoint pt2, CGFloat ratio) {
    return CGPointPlus(CGPointMultiply(pt1, ratio), CGPointMultiply(pt2, 1-ratio));
}

CGPoint CGPointMid(CGPoint pt1, CGPoint pt2) {
    return CGPointSplit(pt1, pt2, 0.5);
}

CGSize CGPointAreaSize(CGPoint pt1, CGPoint pt2) {
    return CGSizeMake(fabs(pt1.x-pt2.x), fabs(pt1.y-pt2.y));
}

CGFloat CGPointArea(CGPoint pt1, CGPoint pt2) {
    CGSize size = CGPointAreaSize(pt1, pt2);
    return size.width * size.height;
}

CGPoint CGPointOrigin(CGPoint pt1, CGPoint pt2) {
    return CGPointMake(fmin(pt1.x, pt2.x), fmin(pt1.y, pt2.y));
}

CGPoint CGPointIntersection(CGPoint from1, CGPoint to1, CGPoint from2, CGPoint to2) {
    CGPoint ac = CGPointMake(to1.x-from1.x, to1.y-from1.y);
    CGPoint bd = CGPointMake(to2.x-from2.x, to2.y-from2.y);
    CGPoint ab = CGPointMake(from2.x-from1.x, from2.y-from1.y);
    CGPoint bc = CGPointMake(to1.x-from2.x, to1.y-from2.y);
    
    CGFloat area1 = CGPointCross(bd, ab);
    CGFloat area2 = CGPointCross(bd, bc);
    
    if (fabs(area1+area2) >= 0.1) {
        CGFloat ratio = area1/(area1+area2);
        return CGPointMake(from1.x+ratio*ac.x, from1.y+ratio*ac.y);
    }
    return CGPointZero;
}

CGPoint CGRectGetRightBottom(CGRect rect) {
    return CGPointMake(CGRectGetMinX(rect)+CGRectGetWidth(rect),
                       CGRectGetMinY(rect)+CGRectGetHeight(rect));
}

CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMultiply(CGPointPlus(rect.origin, CGRectGetRightBottom(rect)), 0.5);
}

CGFloat CGMathRadToDeg(CGFloat rad) {
    return rad * 180 / M_PI;
}

CGFloat CGMathDegToRad(CGFloat deg) {
    return deg * M_PI / 180;
}

CGPoint CGMathCirclePoint(CGPoint center, CGFloat radius, CGFloat rad) {
    CGFloat x = center.x + radius * cosf(rad);
    CGFloat y = center.y + radius * sinf(rad);
    return CGPointMake(x, y);
}
