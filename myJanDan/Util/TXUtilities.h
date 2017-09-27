//
//  TXUtilities.h
//
//  Created by mervin on 2017/9/27.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 将一个 CGSize 以 pt 为单位向上取整
CG_INLINE CGSize
CGSizeCeil(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/// 将一个 CGSize 以 pt 为单位向下取整
CG_INLINE
CGSize CGSizeFloor(CGSize size) {
    return CGSizeMake(floor(size.width), floor(size.height));
}

/// 判断一个size是否为空（宽或高为0）
CG_INLINE BOOL
CGSizeIsEmpty(CGSize size) {
    return size.width <= 0 || size.height <= 0;
}

CG_INLINE CGRect
CGRectSetCenterX(CGRect frame, CGFloat centerX) {
    frame.origin.x = centerX - frame.size.width * 0.5;
    return frame;
}

CG_INLINE CGRect
CGRectSetCenterY(CGRect frame, CGFloat centerY) {
    frame.origin.y = centerY - frame.size.height * 0.5;
    return frame;
}



#define CGSizeMax   CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
