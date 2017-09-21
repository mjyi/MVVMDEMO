//
//  Post_DetailViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/17.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "Post_DetailViewController.h"
#import "PostDetailViewModel.h"
#import <WebKit/WebKit.h>
#import <GRMustache.h>

@interface Post_DetailViewController ()

@property (nonatomic, strong) PostDetailViewModel *viewModel;

@end

@implementation Post_DetailViewController

@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [[self.viewModel.sourceCommand.executionSignals switchToLatest] subscribeNext:^(PostDetailModel *x) {
        @strongify(self)
        NSDictionary *post = @{@"title": x.post.title,
                               @"content": x.post.content
                               };
        NSError *err;
        NSString *rendering = [GRMustacheTemplate renderObject:post fromResource:@"/www/article" bundle:nil error:&err];
        [self.webView loadHTMLString:rendering baseURL:[NSURL URLWithString:x.post.url]];
    }];
    
    [self.viewModel.sourceCommand.errors subscribeNext:^(NSError *x) {
        @strongify(self)
        NSDictionary *post = @{@"title": self.viewModel.postDetail.post.title,
                               @"content": self.viewModel.postDetail.post.content
                               };
        NSError *err;
        NSString *rendering = [GRMustacheTemplate renderObject:post fromResource:@"/www/article" bundle:nil error:&err];
        [self.webView loadHTMLString:rendering baseURL:[NSURL URLWithString:self.viewModel.postDetail.post.url]];
        [self showErrorHUD:x.domain];
    }];
    
    
}

@end
