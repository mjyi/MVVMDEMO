//
//  PicDetail_ViewController.m
//  myJanDan
//
//  Created by mervin on 2017/9/18.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PicDetail_ViewController.h"
#import "PicDetailViewModel.h"
#import <GRMustacheTemplate.h>

@interface PicDetail_ViewController ()

@property (nonatomic, strong) PicDetailViewModel *viewModel;

@end

@implementation PicDetail_ViewController

@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [[self.viewModel.sourceCommand.executionSignals switchToLatest] subscribeNext:^(PicDetailModel *x) {
        @strongify(self)
        NSDictionary *post = @{@"content": x.pic.comment_content};
        NSError *err;
        NSString *rendering = [GRMustacheTemplate renderObject:post fromResource:@"/www/article" bundle:nil error:&err];
        [self.webView loadHTMLString:rendering baseURL:nil];
    }];
    
    [self.viewModel.sourceCommand.errors subscribeNext:^(NSError *x) {
        @strongify(self)
        NSDictionary *post = @{@"content": self.viewModel.picDetail.pic.comment_content};
        NSError *err;
        NSString *rendering = [GRMustacheTemplate renderObject:post fromResource:@"/www/article" bundle:nil error:&err];
        [self.webView loadHTMLString:rendering baseURL:nil];
        [self showErrorHUD:x.domain];
    }];
}



@end
