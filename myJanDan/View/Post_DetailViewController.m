//
//  Post_DetailViewController.m
//  myJanDan
//
//  Created by mervin on 2017/8/17.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "Post_DetailViewController.h"
#import "PostDetailViewModel.h"

@interface Post_DetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) PostDetailViewModel *viewModel;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation Post_DetailViewController

@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (UIWebView *)webView {
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:webView];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        _webView = webView;
    }
    return _webView;
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.requestRemoteDataCommand.executionSignals switchToLatest] subscribeNext:^(PostDetailModel *x) {
        @strongify(self)
        [self.webView loadHTMLString:x.post.content baseURL:nil];
        
    }];
    [self.viewModel.requestRemoteDataCommand.errors subscribeNext:^(id x) {
        @strongify(self)
        [self showErrorHUD:x];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

@end
