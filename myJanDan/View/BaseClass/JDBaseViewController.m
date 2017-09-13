//
//  JDBaseViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDBaseViewController.h"

@interface JDBaseViewController ()

@property (nonatomic, strong, readwrite) JDViewModel *viewModel;

@end

@implementation JDBaseViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.rdv_tabBarController.tabBar.hidden) {
        [self.rdv_tabBarController setTabBarHidden:(self.navigationController.viewControllers.count>1) animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.rdv_tabBarController.tabBar.hidden) {
        [self.rdv_tabBarController setTabBarHidden:(self.navigationController.viewControllers.count>1) animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)bindViewModel {}

- (instancetype)initWithViewModel:(JDViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

@end
