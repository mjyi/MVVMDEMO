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
    return [[[JDHTTPService posts_signalWithPage:page] map:^id(NSDictionary *value) {
        @strongify(self)
        int count = [[value valueForKey:@"count"] intValue];
        if (self.perPage < 0) self.perPage = count;
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value[@"posts"]) {
            PostModel *post = [PostModel modelWithDictionary:dic];
            [array addObject:post];
        }
        return array;
        
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal error:error];
        
    }];
}

@end
