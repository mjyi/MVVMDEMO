//
//  BaseTableViewController.h
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDBaseViewController.h"

@interface BaseTableViewController : JDBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) UIEdgeInsets contentInset;

@end
