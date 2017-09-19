//
//  DetailViewController.m
//  myJanDan
//
//  Created by mervin on 2017/9/18.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) CALayer *progressLayer;

@end

@implementation DetailViewController

@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (WKWebView *)webView {
    if (!_webView) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        configuration.processPool = [[WKProcessPool alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        [self.view addSubview:_webView];
        @weakify(self)
        [[[RACObserve(self.webView, estimatedProgress)
           distinctUntilChanged]
          deliverOnMainThread] subscribeNext:^(NSNumber *progress) {
            @strongify(self)
            float fpro = [progress floatValue];
            self.progressLayer.opacity = 1;
            self.progressLayer.width = kScreen_Width * fpro;
            if (fpro >= 1.0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.progressLayer.opacity = 0;
                });
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.progressLayer.width = 0;
                });
            }
        }];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
    }
    return _webView;
}

- (CALayer *)progressLayer {
    if (!_progressLayer) {
        UIView *progress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 2)];
        progress.backgroundColor = [UIColor clearColor];
        [self.view addSubview:progress];
        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 0, 2);
        _progressLayer.backgroundColor = kColorNavTitle.CGColor;
        [progress.layer addSublayer:self.progressLayer];
    }
    return _progressLayer;
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [self.viewModel.requestRemoteDataCommand.errors subscribeNext:^(NSError *xx) {
        @strongify(self)
        [self showErrorHUD:xx.domain];
    }];
}



@end
