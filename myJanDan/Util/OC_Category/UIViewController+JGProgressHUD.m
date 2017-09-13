//
//  UIViewController+JGProgressHUD.m
//  myJanDan
//
//  Created by mervin on 2017/9/7.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "UIViewController+JGProgressHUD.h"
#import <JGProgressHUD.h>


static char JGProgressHUDKEY;
@implementation UIViewController (JGProgressHUD)

- (JGProgressHUD *)prototypeHUD {
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleExtraLight];
    JGProgressHUDFadeZoomAnimation *an = [JGProgressHUDFadeZoomAnimation animation];
    HUD.animation = an;
    return HUD;
}

- (void)showSimpleHUD:(NSString *)text {
    JGProgressHUD *HUD = self.prototypeHUD;
    if (text)  HUD.textLabel.text = text;
    [HUD showInView:self.view];
}

- (void)showSuccessHUD:(NSString *)success {
    JGProgressHUD *HUD = self.prototypeHUD;
    HUD.textLabel.text = success?:@"Success!";
    HUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
    HUD.square = YES;
    [HUD showInView:self.view];
    [HUD dismissAfterDelay:2];
}

- (void)showErrorHUD:(NSString *)error {
    JGProgressHUD *HUD = self.prototypeHUD;
    HUD.textLabel.text = error ?: @"Error!";
    HUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
    HUD.square = YES;
    [HUD showInView:self.view];
    [HUD dismissAfterDelay:2];
}

- (void)showRingProgress:(CGFloat)progress status:(NSString *)status {
    JGProgressHUD *hud = objc_getAssociatedObject(self,
                                                  &JGProgressHUDKEY);
    if (!hud) {
        hud = [self prototypeHUD];
        hud.indicatorView = [[JGProgressHUDRingIndicatorView alloc] initWithHUDStyle:hud.style];
        if (status) hud.textLabel.text = status;
        objc_setAssociatedObject(self,
                                 &JGProgressHUDKEY,
                                 hud,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [hud showInView:self.view animated:NO];
    }
    
    [hud setProgress:progress animated:NO];
    
    hud.detailTextLabel.text = [NSString stringWithFormat:@"%f%% Complete", progress * 100];
    if (progress >= 1) {
        [hud dismissAnimated:NO];
        objc_setAssociatedObject(self,
                                 &JGProgressHUDKEY,
                                 nil,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)dismissJGHUD {
    
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = self.view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:[JGProgressHUD class]]) [huds addObject:aView];
    }
    for (JGProgressHUD *hud in huds) {
        [hud dismiss];
    }
}

@end
