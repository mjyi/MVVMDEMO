//
//  DetailViewController.m
//  myJanDan
//
//  Created by mervin on 2017/9/18.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIWebViewDelegate>

@end

@implementation DetailViewController

@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSString *loadString = self.title;
    self.loadingView.title = loadString;
    self.navigationItem.titleView = self.loadingView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.navigationItem.titleView = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.navigationItem.titleView = nil;
}

@end
