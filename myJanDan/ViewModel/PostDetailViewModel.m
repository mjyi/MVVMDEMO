//
//  PostDetailViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/17.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PostDetailViewModel.h"
#import "PostDetailModel.h"

@interface PostDetailViewModel ()


@end

@implementation PostDetailViewModel


- (void)initialize {
    self.postDetail = [PostDetailModel new];
    @weakify(self)      //TODO : concat local+remote
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        RACSignal *signal = [RACSignal empty];
        if ([input isKindOfClass:[PostModel class]]) {
            PostModel *post = (PostModel *)input;
            signal = [self requestRemoteDataSignalWithParam:@(post.ID)];
        }
        return [[signal map:^id(PostDetailModel *value) {
            self.title = value.post.title;
            return value;
        }] catch:^RACSignal *(NSError *error) {
            return [RACSignal error:error];
        }];
    }];
    
}



/**
 根据id和slug请求数据  TODO: local store

 @param param 参数（id/slug)
 @return request Signal
 */
- (RACSignal *)requestRemoteDataSignalWithParam:(id)param {
    
    if ([param isKindOfClass:[NSNumber class]]) {
        return [[[JDHTTPService postDetail_signalWithId:[param integerValue]] map:^id(NSDictionary *value) {
            //        NSDictionary *dict = value[@"post"];
            PostDetailModel *postDetail = [PostDetailModel modelWithJSON:value];
            return postDetail;
        }] catch:^RACSignal *(NSError *error) {
            return [RACSignal error:error];
        }];
    }
    return [RACSignal empty];
    
}


@end
