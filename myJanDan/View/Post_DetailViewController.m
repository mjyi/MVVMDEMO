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
//
//- (WKWebView *)webView {
//    if (!_webView) {
//        
//        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//        configuration.userContentController = [WKUserContentController new];
//        
//        WKPreferences *preferences = [WKPreferences new];
//        preferences.javaScriptCanOpenWindowsAutomatically = YES;
//        configuration.preferences = preferences;
//        configuration.processPool = [[WKProcessPool alloc] init];
//        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
//        [self.view addSubview:_webView];
//        @weakify(self)
//        [[[RACObserve(self.webView, estimatedProgress)
//         distinctUntilChanged]
//          deliverOnMainThread] subscribeNext:^(NSNumber *progress) {
//            @strongify(self)
//            float fpro = [progress floatValue];
//            self.progressLayer.opacity = 1;
//            self.progressLayer.width = kScreen_Width * fpro;
//            if (fpro >= 1.0) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    self.progressLayer.opacity = 0;
//                });
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    self.progressLayer.width = 0;
//                });
//            }
//        }];
//        _webView.navigationDelegate = self;
//        _webView.UIDelegate = self;
//        
//    }
//    return _webView;
//}
//
//- (CALayer *)progressLayer {
//    if (!_progressLayer) {
//        UIView *progress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 2)];
//        progress.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:progress];
//        _progressLayer = [CALayer layer];
//        _progressLayer.frame = CGRectMake(0, 0, 0, 2);
//        _progressLayer.backgroundColor = kColorNavTitle.CGColor;
//        [progress.layer addSublayer:self.progressLayer];
//    }
//    return _progressLayer;
//}


- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [[self.viewModel.requestRemoteDataCommand.executionSignals switchToLatest] subscribeNext:^(PostDetailModel *x) {
        @strongify(self)
        
        NSDictionary *post = @{@"title": x.post.title,
                               @"content": x.post.content
                               };
        NSError *err;
        NSString *rendering = [GRMustacheTemplate renderObject:post fromResource:@"/www/article" bundle:nil error:&err];
        
        [self.webView loadHTMLString:rendering baseURL:nil];
    }];
}

@end
