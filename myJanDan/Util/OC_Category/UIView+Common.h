//
//  UIView+Common.h
//  myJanDan
//
//  Created by mervin on 2017/8/28.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

@property(nonatomic, strong) CAShapeLayer *cc_progressLayer;

- (void)showPropress:(CGFloat)progress;

- (void)hideProgress;

@end
