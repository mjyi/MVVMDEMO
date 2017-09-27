//
//  BaseTableViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "BaseTableViewController.h"
#import "TableViewModel.h"

@interface BaseTableViewController ()

@property (nonatomic, strong, readonly)TableViewModel *viewModel;

@end

@implementation BaseTableViewController

@synthesize viewModel;

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = self.contentInset;
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.layoutMargins = UIEdgeInsetsZero;
        tableView.separatorColor = kColorCellLine;
        tableView;
    });
    
    @weakify(self)
    if (self.viewModel.shouldPullToRefresh) {
        [self.tableView addPullToRefreshWithActionHandler:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand
               execute:@(1)]
              deliverOnMainThread]
             subscribeNext:^(NSArray *results) {
                 @strongify(self)
                 self.viewModel.page = 1;
             } completed:^{
                 @strongify(self)
                 [self.tableView.pullToRefreshView stopAnimating];
             }];
        }];
    }
    
    if (self.viewModel.shouldInfiniteScrolling) {
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand
               execute:@(self.viewModel.page + 1)]
              deliverOnMainThread]
             subscribeNext:^(NSArray *results) {
                 @strongify(self)
                 self.viewModel.page += 1;
             } completed:^{
                 @strongify(self)
                 [self.tableView.infiniteScrollingView stopAnimating];
             }];
            
        }];
    }
    RAC(self.tableView,
        showsInfiniteScrolling) = [[[RACObserve(self.viewModel, dataSource)
                                     distinctUntilChanged]
                                    deliverOnMainThread]
                                   map:^id(NSArray *dataSource) {
                                       @strongify(self)
                                       NSInteger count = 0;
                                       NSArray *arr = dataSource[0];
                                       
                                       count += arr.count;
                                       return @(count >= self.viewModel.perPage);
                                   }];
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [[[RACObserve(self.viewModel, dataSource)
       distinctUntilChanged]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         [self.tableView reloadData];
     }];
    [self.viewModel.errors subscribeNext:^(NSError *x) {
        @strongify(self)
        [self showErrorHUD:x.domain];
        [self.tableView.infiniteScrollingView stopAnimating];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
    
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *x) {
        @strongify(self)
        if (x.boolValue) {
            self.navigationItem.titleView = self.loadingView;
        } else {
            self.navigationItem.titleView = nil;
        }
    }];
}


#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.viewModel.dataSource[section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

@end
