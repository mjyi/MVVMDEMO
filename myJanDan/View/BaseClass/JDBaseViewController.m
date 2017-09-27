//
//  JDBaseViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDBaseViewController.h"
#import "TitleLoadingView.h"

@interface JDBaseViewController ()

@property (nonatomic, strong, readwrite) JDViewModel *viewModel;

@end

@implementation JDBaseViewController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self bindViewModel];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(self.viewModel, title);
}

- (instancetype)initWithViewModel:(JDViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (TitleLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[TitleLoadingView alloc] init];
        _loadingView.tintColor = kColorNavTitle;
    }
    return _loadingView;
}

- (void)dealloc {
    DebugLog(@" <<<< %@ >>>>", self.className);
}

@end
