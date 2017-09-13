//
//  Me_RootViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/29.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "Me_RootViewController.h"
#import "MeSettingViewModel.h"
#import "SettingCell.h"
#import "SettingsHelper.h"

@interface Me_RootViewController ()

@property(nonatomic, strong)MeSettingViewModel *viewModel;

@end

@implementation Me_RootViewController

@synthesize viewModel;

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, self.rdv_tabBarController.tabBar.minimumContentHeight, 0);
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:[SettingCell className]
                                               bundle:nil]
         forCellReuseIdentifier:[SettingCell className]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)bindViewModel {
    [super bindViewModel];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[SettingCell className]];
    
    cell.titleLabel.text = @"清除图片缓存";
    cell.detailLabel.text = self.viewModel.cacheString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [SettingsHelper cleanDefaultImageCacheOnDisk:^(int removedCount, int totalCount) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showRingProgress:((float)removedCount/totalCount)
                            status:@"正在删除…"];
        });
    } endBlock:^(BOOL error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!error) {
                [self showSuccessHUD:@"清除成功"];
            } else {
                [self showErrorHUD:@"清除失败"];
            }
            [self.tableView reloadData];
        });
    }];
    
    
}

@end
