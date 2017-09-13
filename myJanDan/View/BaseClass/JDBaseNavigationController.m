//
//  JDBaseNavigationController.m
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDBaseNavigationController.h"

@interface JDBaseNavigationController ()

@end

@implementation JDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideBorderInView:self.navigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)hideBorderInView:(UIView *)view {
    for (UIView *sv in view.subviews) {
        if ([sv isKindOfClass:[UIImageView class]] &&
            sv.height < 1) {
            sv.hidden = YES;
        }
    }
}

@end
