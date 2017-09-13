//
//  BaseTableViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "BaseTableViewController.h"
#import "TableViewModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BaseTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

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
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.layoutMargins = UIEdgeInsetsZero;
        tableView.separatorColor = [UIColor redColor];
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
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
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.pullToRefreshView stopAnimating];
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
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.infiniteScrollingView stopAnimating];
             } completed:^{
                 @strongify(self)
                 [self.tableView.infiniteScrollingView stopAnimating];
             }];
            
        }];
    }
    RAC(self.tableView, showsInfiniteScrolling) = [[[RACObserve(self.viewModel, dataSource)
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//    [self.viewModel.requestRemoteDataCommand.errors subscribeNext:^(NSError *x) {
//        @strongify(self)
//        [self showErrorHUD:x.domain];
//    }];
    
    [RACObserve(self.viewModel, title) subscribeNext:^(NSString *title) {
        @strongify(self)
        self.title = title;
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


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Data loaded";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    return nil;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}


#pragma mark - DZNEmptyDataSetSource Methods

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return NO;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"%s",__FUNCTION__);
    [self.viewModel.requestRemoteDataCommand execute:@1];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    
    NSLog(@"%s",__FUNCTION__);
}


@end
