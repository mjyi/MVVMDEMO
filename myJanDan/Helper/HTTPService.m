//
//  HTTPService.m
//  myJanDan
//
//  Created by mervin on 2017/8/15.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "HTTPService.h"

@interface HTTPService ()

@end

@implementation HTTPService

+ (HTTPService *)shareInstance {
    static HTTPService *httpService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpService = [[HTTPService alloc] init];
    });
    return httpService;
}

#pragma mark- override
- (void)prepareRequest:(MKNetworkRequest *)networkRequest {
    [super prepareRequest:networkRequest];
    networkRequest.request.timeoutInterval = 20;
}

#pragma mark - Public

- (RACSignal *)posts_signalWithPage:(NSInteger)page {
    NSString *url = [NSString stringWithFormat:@"%@%ld",kPostsURL, page];
    return [self rac_signalWithURLString:url];
}

- (RACSignal *)postDetail_signalWithId:(NSInteger)ID {
    NSString *url = [NSString stringWithFormat:@"%@%ld",kPostById, ID];
    RACSignal *signal = [self rac_signalWithURLString:url];
    return [self requestStatusSignal:signal];
    
}

- (RACSignal *)pic_signalWithPage:(NSInteger)page {
    NSString *url = [NSString stringWithFormat:@"%@%ld", kPicURL, page];
    RACSignal *signal = [self rac_signalWithURLString:url];
    return [self requestStatusSignal:signal];

}

- (RACSignal *)xxoo_signalWithPage:(NSInteger)page {
    NSString *url = [NSString stringWithFormat:@"%@%ld", kXXOOURL, page];
    RACSignal *signal = [self rac_signalWithURLString:url];
    return [self requestStatusSignal:signal];
    
}

- (RACSignal *)duan_SignalWithPage:(NSInteger)page {
    NSString *url = [NSString stringWithFormat:@"%@%ld", kDuanURL, page];
    RACSignal *signal = [self rac_signalWithURLString:url];
    return [self requestStatusSignal:signal];
    
}

// Code
- (RACSignal *)tucao_SignalWithCommentID:(NSString *)commentID {
    NSString *url = [NSString stringWithFormat:@"%@%@", kTucaoURL, commentID];
    return [self rac_signalWithURLString:url];
}

- (RACSignal *)requestStatusSignal:(RACSignal *)signal {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RACDisposable *subscriptionDisposable = [signal subscribeNext:^(NSDictionary *dict) {
            if ([dict[@"status"] isEqualToString:@"ok"]) {
                [subscriber sendNext:dict];
            } else {
                [subscriber sendError:[NSError errorWithDomain:@"服务器返回失败" code:0 userInfo:nil]];
            }
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            [subscriptionDisposable dispose];
        }];
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal error:error];
    }];
}

- (RACSignal *)requestCodeSignal:(RACSignal *)signal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RACDisposable *subscriptionDisposable = [signal subscribeNext:^(NSDictionary *dict) {
            if (0 == [dict[@"code"] intValue]) {
                [subscriber sendNext:dict];
            } else {
                [subscriber sendError:[NSError errorWithDomain:@"服务器返回失败" code:0 userInfo:nil]];
            }
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            [subscriptionDisposable dispose];
        }];
    }];
}


#pragma mark - Privity method
- (RACSignal *)rac_signalWithURLString:(NSString *)URLString {
    @weakify(self)
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MKNetworkRequest *request = [[MKNetworkRequest alloc] initWithURLString:URLString params:nil bodyData:nil httpMethod:@"GET"];
        @strongify(self)
        [request addCompletionHandler:^(MKNetworkRequest *completedRequest) {

            if (completedRequest.error) {
                [subscriber sendError:completedRequest.error];
                return;
            }
            [subscriber sendNext:completedRequest.responseAsJSON];
            [subscriber sendCompleted];
        }];
        [self startRequest:request];
        
        return [RACDisposable disposableWithBlock:^{
            [request cancel];
        }];
    }] replayLast];
}

@end
