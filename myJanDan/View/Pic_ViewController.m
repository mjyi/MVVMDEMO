//
//  Pic_ViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "Pic_ViewController.h"
#import "Pic_ViewModel.h"
#import "Pic_Cell.h"
#import "PicDetailViewModel.h"
#import "PicDetail_ViewController.h"

@interface Pic_ViewController ()

@property (nonatomic, strong)Pic_ViewModel *viewModel;

@end

@implementation Pic_ViewController

@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"Pic_Cell" bundle:nil] forCellReuseIdentifier:[Pic_Cell className]];
    [self.viewModel.requestRemoteDataCommand execute:@1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)bindViewModel {
    [super bindViewModel];
    
    [[self.viewModel.didSelected.executionSignals switchToLatest] subscribeNext:^(PicModel *item) {
//        DebugLog(@"didSelected: %@",item);
        PicDetailViewModel *pViewModel = [[PicDetailViewModel alloc] init];
        PicDetailModel *dtt = [PicDetailModel new];
        dtt.pic = item;
        pViewModel.picDetail = dtt;
        PicDetail_ViewController *dctrl = [[PicDetail_ViewController alloc] initWithViewModel:pViewModel];
        
        [[dctrl rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
            [pViewModel.sourceCommand execute:item];
            
        }];
        [self.navigationController pushViewController:dctrl
                                             animated:YES];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PicModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    return model.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Pic_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[Pic_Cell className] forIndexPath:indexPath];
    PicModel *pic = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [cell setLayout:pic];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel.didSelected execute:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Pic_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        if ([subView isKindOfClass:[YYAnimatedImageView class]]) {
            YYAnimatedImageView *aV = (YYAnimatedImageView *)subView;
//            DebugLog(@"size:{%f, %f}", aV.image.size.width, aV.image.size.height);
        }
    }
}


@end
