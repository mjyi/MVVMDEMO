//
//  PostDetailViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/17.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PostDetailViewModel.h"
#import "PostDetailModel.h"
#import <GRMustache.h>

@implementation PostDetailViewModel


- (void)initialize {
    [super initialize];
    @weakify(self)      //TODO : concat local+remote
    self.sourceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(PostModel *post) {
        @strongify(self)
        RACSignal *signal = [self requestRemoteDataSignalWithParam:@(post.ID)];
        return [[signal map:^id(PostDetailModel *value) {
            self.title = value.post.title;
            self.postDetail = value;
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
- (RACSignal *)requestRemoteDataSignalWithParam:(NSNumber *)param {
    
        return [[[JDHTTPService postDetail_signalWithId:[param integerValue]] map:^id(NSDictionary *value) {
            //        NSDictionary *dict = value[@"post"];
            PostDetailModel *postDetail = [PostDetailModel modelWithJSON:value];
            
            return postDetail;
        }] catch:^RACSignal *(NSError *error) {
            return [RACSignal error:error];
        }];
    
}


@end
