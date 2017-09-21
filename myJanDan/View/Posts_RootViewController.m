//
//  Posts_RootViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "Posts_RootViewController.h"
#import "PostViewModel.h"
#import "PostItemCell.h"
#import "SVPullToRefresh.h"
#import "PostsItemViewModel.h"
#import "PostModel.h"
#import "PostDetailViewModel.h"
#import "Post_DetailViewController.h"

#define PostCellIdentifier  @"PostCellIdentifier"

@interface Posts_RootViewController ()

@property (nonatomic, strong)PostViewModel *viewModel;

@end

@implementation Posts_RootViewController

@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PostItemCell" bundle:nil] forCellReuseIdentifier:PostCellIdentifier];
    self.tableView.rowHeight = 100;

    [self.viewModel.requestRemoteDataCommand execute:@1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [[self.viewModel.didSelected.executionSignals switchToLatest] subscribeNext:^(PostModel *item) {
        @strongify(self)
        PostDetailViewModel *dviewModel = [[PostDetailViewModel alloc] init];
//
        Post_DetailViewController *detail = [[Post_DetailViewController alloc] initWithViewModel:dviewModel];
        
        [[detail rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
            [dviewModel.sourceCommand execute:item];
            
        }];
        [self.navigationController pushViewController:detail
                                             animated:YES];
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostItemCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellIdentifier forIndexPath:indexPath];
    PostsItemViewModel *vm = [PostsItemViewModel new];
    vm.post = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [cell bindViewModel:vm];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelected execute:indexPath];
}

@end
