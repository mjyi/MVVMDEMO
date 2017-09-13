//
//  UIViewController+JGProgressHUD.h
//  myJanDan
//
//  Created by mervin on 2017/9/7.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGProgressHUD;
@interface UIViewController (JGProgressHUD)

- (void)showSimpleHUD:(NSString *)text;

- (void)showSuccessHUD:(NSString *)success;

- (void)showErrorHUD:(NSString *)error;

- (void)showRingProgress:(CGFloat)progress status:(NSString *)status;

- (void)dismissJGHUD;

@end
