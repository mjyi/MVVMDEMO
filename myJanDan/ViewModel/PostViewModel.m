//
//  PostViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/14.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PostViewModel.h"
#import "HTTPService.h"
#import "PostModel.h"

@interface PostViewModel ()

@end

@implementation PostViewModel

- (void) initialize {
    [super initialize];
    self.title = posts_Title;
    self.page = 1;
    @weakify(self)
    [self.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *x) {
        @strongify(self)
        if (x.boolValue) {
            self.title = loading_Title;
        } else {
            self.title = posts_Title;
        }
     }];
}


// TODO: to complete local store
- (RACSignal *)fetchLocalData {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@[]];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    self.curPage = page;
    @weakify(self)
    return [[JDHTTPService posts_signalWithPage:page] map:^id(id value) {
        @strongify(self)
        return [self analysisOfResponse:value];
    }];
}

-(NSArray *)analysisOfResponse:(id)response {
    NSDictionary *value = (NSDictionary *)response;
    NSMutableArray *array = [NSMutableArray array];
    if ([value[@"status"] isEqualToString:@"ok"]) {
        int count = [[value valueForKey:@"count"] intValue];
        if (self.perPage < 0) self.perPage = count;
        for (NSDictionary *dic in value[@"posts"]) {
            PostModel *post = [PostModel modelWithDictionary:dic];
            [array addObject:post];
        }
        return array;
    }
    [self.errors sendNext:[NSError errorWithDomain:@"服务器返回异常" code:0 userInfo:nil]];
    return array;
}

@end
