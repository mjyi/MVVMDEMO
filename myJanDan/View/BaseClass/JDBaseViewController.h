//
//  JDBaseViewController.h
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDViewModel.h"
#import "TitleLoadingView.h"

@interface JDBaseViewController : UIViewController

@property (nonatomic, strong, readonly)JDViewModel *viewModel;

@property(nonatomic, strong) TitleLoadingView *loadingView;

- (void)bindViewModel;
//
- (instancetype)initWithViewModel:(JDViewModel *)viewModel;

@end
