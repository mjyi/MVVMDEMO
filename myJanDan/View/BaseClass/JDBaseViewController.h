//
//  JDBaseViewController.h
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDViewModel.h"

@interface JDBaseViewController : UIViewController

@property (nonatomic, strong, readonly)JDViewModel *viewModel;

- (void)bindViewModel;

//
- (instancetype)initWithViewModel:(JDViewModel *)viewModel;

@end
