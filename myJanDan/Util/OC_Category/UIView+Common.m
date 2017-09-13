//
//  UIView+Common.m
//  myJanDan
//
//  Created by mervin on 2017/8/28.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "UIView+Common.h"
#import <objc/runtime.h>

static char CC_PROGRESSLAYER;
@implementation UIView (Common)

- (void)setCc_progressLayer:(CAShapeLayer *)cc_progressLayer {
    objc_setAssociatedObject(self,
                             &CC_PROGRESSLAYER,
                             cc_progressLayer,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)cc_progressLayer {
    return objc_getAssociatedObject(self, &CC_PROGRESSLAYER);
}

- (void)showPropress:(CGFloat)progress {
    if (!self.cc_progressLayer) {
        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.size = CGSizeMake(40, 40);
        progressLayer.cornerRadius = 20;
        progressLayer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(progressLayer.bounds, 7, 7) cornerRadius:(40 / 2 - 7)];
        progressLayer.path = path.CGPath;
        progressLayer.fillColor = [UIColor clearColor].CGColor;
        progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        progressLayer.lineWidth = 4;
        progressLayer.lineCap = kCALineCapRound;
        progressLayer.strokeStart = 0;
        progressLayer.strokeEnd = 0;
        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
        progressLayer.strokeEnd = 0;
        [CATransaction commit];
        [self.layer addSublayer:progressLayer];
        self.cc_progressLayer = progressLayer;
        
    }
    self.cc_progressLayer.hidden = NO;
    self.cc_progressLayer.strokeEnd = (progress > 1) ? 1 : (progress < 0.01) ? 0.01: progress;
}

- (void)hideProgress {
//    [self.cc_progressLayer removeFromSuperlayer];
    self.cc_progressLayer.hidden = YES;
}


- (void)layoutSubviews {
    self.cc_progressLayer.center = CGPointMake(self.width/2, self.height/2);
}

@end
