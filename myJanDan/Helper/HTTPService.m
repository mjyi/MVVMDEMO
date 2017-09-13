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
}

#pragma mark - Public

- (RACSignal *)posts_signalWithPage:(NSInteger)page {
    NSString *url = [NSString stringWithFormat:@"%@%ld",kPostsURL, page];
    return [self rac_signalWithURLString:url];
    
}

- (RACSignal *)postDetail_signalWithId:(NSInteger)ID {
    NSString *url = [NSString stringWithFormat:@"%@%ld",kPostById, ID];
    return [self rac_signalWithURLString:url];
    
}

- (RACSignal *)pic_signalWithPage:(NSInteger)page {
    
    NSString *url = [NSString stringWithFormat:@"%@%ld", kPicURL, page];
    return [self rac_signalWithURLString:url];

}

- (RACSignal *)xxoo_signalWithPage:(NSInteger)page {
    NSString *url = [NSString stringWithFormat:@"%@%ld", kXXOOURL, page];
    return [self rac_signalWithURLString:url];
    
}

- (RACSignal *)duan_SignalWithPage:(NSInteger)page {
    NSString *url = [NSString stringWithFormat:@"%@%ld", kDuanURL, page];
    return [self rac_signalWithURLString:url];
    
}

#pragma mark - Privity method
- (RACSignal *)rac_signalWithURLString:(NSString *)URLString {
    @weakify(self)
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MKNetworkRequest *request = [[MKNetworkRequest alloc] initWithURLString:URLString params:nil bodyData:nil httpMethod:@"GET"];
        @strongify(self)
        [request addCompletionHandler:^(MKNetworkRequest *completedRequest) {
            DebugLog(@"%@",completedRequest.responseAsJSON);
            NSDictionary *dict = (NSDictionary *)completedRequest.responseAsJSON;
            if (completedRequest.error) {
                
                [subscriber sendError:completedRequest.error];
            } else if ([completedRequest.responseAsJSON[@"status"] isEqualToString:@"ok"]) {
                
                [subscriber sendNext:completedRequest.responseAsJSON];
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:[NSError errorWithDomain:[NSString stringWithFormat:@"Status:%@",dict[@"status"]]
                                                          code:0
                                                      userInfo:nil]];
            }
        }];
        [self startRequest:request];
        
        return [RACDisposable disposableWithBlock:^{
            [request cancel];
        }];
    }] replayLast];
}

@end
